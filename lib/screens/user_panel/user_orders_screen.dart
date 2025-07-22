// ignore_for_file: unnecessary_null_comparison, unused_local_variable, body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegarments/models/order_model.dart';
import 'package:thegarments/screens/user_panel/user_order_detail_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class UserOrdersScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.primeryColor,
        title: Text('My Order\'s'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Order')
              .doc(user!.uid)
              .collection('ConformOrder')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> DocumentSnapshot) {
            if (DocumentSnapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Some error occured'),
                ),
              );
            }
            if (DocumentSnapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            if (DocumentSnapshot == null ||
                DocumentSnapshot.data!.docs.isEmpty) {
              return Container(
                child: Center(
                  child: Text('Your order list is empty!'),
                ),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: DocumentSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final OrderData = DocumentSnapshot.data!.docs[index];
                  String orderid = OrderData.id;
                  OrderModel orderModel = OrderModel(
                    ProductId: OrderData['ProductId'],
                    CategoryId: OrderData['CategoryId'],
                    ProductName: OrderData['ProductName'],
                    CategoryName: OrderData['CategoryName'],
                    SalePrice: OrderData['SalePrice'],
                    FullPrice: OrderData['FullPrice'],
                    ProductImg: OrderData['ProductImg'],
                    DeliveryTime: OrderData['DeliveryTime'],
                    issale: OrderData['issale'],
                    ProductDescription: OrderData['ProductDescription'],
                    CreatedAt: OrderData['CreatedAt'],
                    UpdatedAt: OrderData['UpdatedAt'],
                    ProductQuantity: OrderData['ProductQuantity'],
                    ProductTotalPrice: OrderData['ProductTotalPrice'],
                    CustomerId: OrderData['CustomerId'],
                    Status: OrderData['Status'],
                    CustomerName: OrderData['CustomerName'],
                    CustomerPhoneNumber: OrderData['CustomerPhoneNumber'],
                    CustomerAddress: OrderData['CustomerAddress'],
                    CustomerDeviceToken: OrderData['CustomerDeviceToken'],
                  );
                  return GestureDetector(
                    onTap: () => Get.to(
                        () => UserOrderDetailScreen(orderModel: orderModel)),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(orderModel.ProductImg),
                        ),
                        title: Text(
                          orderModel.ProductName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'Total: ${orderModel.issale ? orderModel.SalePrice : orderModel.FullPrice}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              orderModel.Status != true
                                  ? 'Pending.'
                                  : 'Delivered.',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
