// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegarments/screens/admin_panel/specify_order_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Order\'s'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Order').snapshots(),
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
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot == null || snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No Order found!'),
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var orderdata = snapshot.data!.docs[index];
                // OrderModel orderModel = OrderModel(
                //     ProductId: orderdata['ProductId'],
                //     CategoryId: orderdata['CategoryId'],
                //     ProductName: orderdata['ProductName'],
                //     CategoryName: orderdata['CategoryName'],
                //     SalePrice: orderdata['SalePrice'],
                //     FullPrice: orderdata['FullPrice'],
                //     ProductImg: orderdata['ProductImg'],
                //     DeliveryTime: orderdata['DeliveryTime'],
                //     issale: orderdata['issale'],
                //     ProductDescription: orderdata['ProductDescription'],
                //     CreatedAt: orderdata['CreatedAt'],
                //     UpdatedAt: orderdata['UpdatedAt'],
                //     ProductQuantity: orderdata['ProductQuantity'],
                //     ProductTotalPrice: orderdata['ProductTotalPrice'],
                //     CustomerId: orderdata['CustomerId'],
                //     Status: orderdata['Status'],
                //     CustomerName: orderdata['CustomerName'],
                //     CustomerPhoneNumber: orderdata['CustomerPhoneNumber'],
                //     CustomerAddress: orderdata['CustomerAddress'],
                //     CustomerDeviceToken: orderdata['CustomerDeviceToken']);
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SpecifyOrderScreen(docid: orderdata['UId']));
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.secondaryColor,
                        child: Text(orderdata['CustomerName'][0]),
                      ),
                      title: Text(orderdata['CustomerName']),
                      subtitle: Row(
                        children: [
                          Text(
                            'Cus:ID: ${orderdata['UId']}',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
