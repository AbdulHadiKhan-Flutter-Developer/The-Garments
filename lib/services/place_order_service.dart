// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:thegarments/models/order_model.dart';
import 'package:thegarments/screens/user_panel/main_screen.dart';
import 'package:thegarments/services/generate-random-orderid.dart';

void PlaceOrder(
    {required String name,
    required String address,
    required String phonenumber,
    required String devicetoken}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: 'Please Wait');
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Cart')
          .doc(user.uid)
          .collection('CartItem')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String RandomOrderId = GenerateRandomOrderId();
        OrderModel orderModel = OrderModel(
            ProductId: data['ProductId'],
            CategoryId: data['CategoryId'],
            ProductName: data['ProductName'],
            CategoryName: data['CategoryName'],
            SalePrice: data['SalePrice'],
            FullPrice: data['FullPrice'],
            ProductImg: data['ProductImg'],
            DeliveryTime: data['DeliveryTime'],
            issale: data['issale'],
            ProductDescription: data['ProductDescription'],
            CreatedAt: DateTime.now(),
            UpdatedAt: data['UpdatedAt'],
            ProductQuantity: data['ProductQuantity'],
            ProductTotalPrice:
                double.parse(data['ProductTotalPrice'].toString()),
            CustomerId: user.uid,
            Status: false,
            CustomerName: name,
            CustomerAddress: address,
            CustomerPhoneNumber: phonenumber,
            CustomerDeviceToken: devicetoken);

        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection('Order')
              .doc(user.uid)
              .set({
            'UId': user.uid,
            'CustomerName': name,
            'CustomerAddress': address,
            'CustomerPhoneNumber': phonenumber,
            'Status': false,
            'CustomerDeviceToken': devicetoken,
            'CreatedAt': DateTime.now()
          });

          await FirebaseFirestore.instance
              .collection('Order')
              .doc(user.uid)
              .collection('ConformOrder')
              .doc(RandomOrderId)
              .set(orderModel.toMap());

          await FirebaseFirestore.instance
              .collection('Cart')
              .doc(user.uid)
              .collection('CartItem')
              .doc(orderModel.ProductId)
              .delete();
        }
      }
      Get.snackbar(
          'Order Conformed', 'You\'r Order Will be delivered within 2 day\'s');
      EasyLoading.dismiss();
      Get.offAll(() => MainScreen());
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }
}
