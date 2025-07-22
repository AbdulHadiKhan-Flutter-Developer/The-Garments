// ignore_for_file: unnecessary_null_comparison, unused_local_variable, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:thegarments/controller/get_customer_device_token.dart';
import 'package:thegarments/controller/subtotal_controller.dart';

import 'package:thegarments/models/cart_model.dart';
import 'package:thegarments/services/place_order_service.dart';

import 'package:thegarments/utils/app_constant.dart';

class CheckoutScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final SubtotalController subtotalController = Get.put(SubtotalController());
  TextEditingController CustomerNameController = TextEditingController();
  TextEditingController CustomerPhoneNumberController = TextEditingController();
  TextEditingController CustomerAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.primeryColor,
        title: Text('Conform Order'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Cart')
            .doc(user!.uid)
            .collection('CartItem')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> documentsnapshot) {
          if (documentsnapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Some error Occured'),
              ),
            );
          }
          if (documentsnapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (documentsnapshot == null || documentsnapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No Cart Item found'),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: documentsnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final cartdata = documentsnapshot.data!.docs[index];
              CartModel cartModel = CartModel(
                  ProductId: cartdata['ProductId'],
                  CategoryId: cartdata['CategoryId'],
                  ProductName: cartdata['ProductName'],
                  CategoryName: cartdata['CategoryName'],
                  SalePrice: cartdata['SalePrice'],
                  FullPrice: cartdata['FullPrice'],
                  ProductImg: cartdata['ProductImg'],
                  DeliveryTime: cartdata['DeliveryTime'],
                  issale: cartdata['issale'],
                  ProductDescription: cartdata['ProductDescription'],
                  CreatedAt: cartdata['CreatedAt'],
                  UpdatedAt: cartdata['UpdatedAt'],
                  ProductQuantity: cartdata['ProductQuantity'],
                  ProductTotalPrice: cartdata['ProductTotalPrice']);
              return SwipeActionCell(
                key: ObjectKey(cartModel.ProductId),
                trailingActions: [
                  SwipeAction(
                      onTap: (CompletionHandler handler) async {
                        print('Deleted');
                        await FirebaseFirestore.instance
                            .collection('Cart')
                            .doc(user!.uid)
                            .collection('CartItem')
                            .doc(cartModel.ProductId)
                            .delete();
                      },
                      title: 'Delete',
                      forceAlignmentToBoundary: true,
                      performsFirstActionWithFullSwipe: true)
                ],
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(cartModel.ProductImg),
                    ),
                    title: Text(
                      cartModel.ProductName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          'Total: ${cartModel.ProductTotalPrice.toString()}-pkr',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Chip(
                    shadowColor: AppConstant.secondaryColor,
                    label: Text(
                        'SubTotal: ${subtotalController.subtotal.value}-pkr ')),
              ),
              ElevatedButton(
                onPressed: () {
                  showbottomsheet();
                },
                child: Text(
                  'Select Address',
                  style: TextStyle(
                      color: AppConstant.textColor,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.secondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showbottomsheet() {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TextFormField(
                controller: CustomerNameController,
                cursorColor: AppConstant.secondaryColor,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TextFormField(
                controller: CustomerPhoneNumberController,
                cursorColor: AppConstant.secondaryColor,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Phone Number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TextFormField(
                controller: CustomerAddressController,
                cursorColor: AppConstant.secondaryColor,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Address'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (CustomerNameController.text != null &&
                    CustomerPhoneNumberController.text != null &&
                    CustomerAddressController.text != null) {
                  String CustomerName = CustomerNameController.text.trim();
                  String CustomerAddress =
                      CustomerAddressController.text.trim();
                  String CustomerPhoneNUmber =
                      CustomerPhoneNumberController.text.trim();
                  String CustomerDeviceToken = await getcustomerdevicetoken();
                  PlaceOrder(
                    name: CustomerName,
                    address: CustomerAddress,
                    phonenumber: CustomerPhoneNUmber,
                    devicetoken: CustomerDeviceToken,
                  );
                  print('Customer Device Token : $CustomerDeviceToken');
                } else {
                  print('Please Enter your data!');
                }
              },
              child: Text(
                'Conform Order',
                style: TextStyle(color: AppConstant.textColor),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstant.secondaryColor),
            )
          ],
        ),
      ),
    ));
  }
}
