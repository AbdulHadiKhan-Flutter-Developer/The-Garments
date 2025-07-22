// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegarments/models/order_model.dart';
import 'package:thegarments/screens/admin_panel/order_detail_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class SpecifyOrderScreen extends StatelessWidget {
  final String docid;
  SpecifyOrderScreen({required this.docid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Specify Order\'s'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Order')
              .doc(docid)
              .collection('ConformOrder')
              .snapshots(),
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Some Error Occured'),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(child: CupertinoActivityIndicator()),
              );
            }
            if (snapshot == null || snapshot.data!.docs.isEmpty) {
              return Container(
                child: Center(
                  child: Text('No Specify Order Found'),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var specifyorderdata = snapshot.data!.docs[index];
                  String orderid = specifyorderdata.id;
                  OrderModel orderModel = OrderModel(
                      ProductId: specifyorderdata['ProductId'],
                      CategoryId: specifyorderdata['CategoryId'],
                      ProductName: specifyorderdata['ProductName'],
                      CategoryName: specifyorderdata['CategoryName'],
                      SalePrice: specifyorderdata['SalePrice'],
                      FullPrice: specifyorderdata['FullPrice'],
                      ProductImg: specifyorderdata['ProductImg'],
                      DeliveryTime: specifyorderdata['DeliveryTime'],
                      issale: specifyorderdata['issale'],
                      ProductDescription:
                          specifyorderdata['ProductDescription'],
                      CreatedAt: specifyorderdata['CreatedAt'],
                      UpdatedAt: specifyorderdata['UpdatedAt'],
                      ProductQuantity: specifyorderdata['ProductQuantity'],
                      ProductTotalPrice: specifyorderdata['ProductTotalPrice'],
                      CustomerId: specifyorderdata['CustomerId'],
                      Status: specifyorderdata['Status'],
                      CustomerName: specifyorderdata['CustomerName'],
                      CustomerPhoneNumber:
                          specifyorderdata['CustomerPhoneNumber'],
                      CustomerAddress: specifyorderdata['CustomerAddress'],
                      CustomerDeviceToken:
                          specifyorderdata['CustomerDeviceToken']);
                  return GestureDetector(
                    onTap: () => Get.to(() => OrderDetailScreen(
                        userid: docid,
                        orderModel: orderModel,
                        orderid: orderid)),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.secondaryColor,
                          child: Text(orderModel.CategoryName[0]),
                        ),
                        title: Text(orderModel.CustomerName),
                        subtitle: Row(
                          children: [
                            Text(
                              'Ord:Status: ${orderModel.Status == false ? 'Pending.' : 'Delivered.'}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          })),
    );
  }
}
