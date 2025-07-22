// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:thegarments/models/order_model.dart';
import 'package:thegarments/utils/app_constant.dart';

class OrderDetailScreen extends StatelessWidget {
  final String userid;
  OrderModel orderModel;
  final String orderid;

  OrderDetailScreen(
      {required this.userid, required this.orderModel, required this.orderid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Order Detail\'s'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Customer Detail\'s',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              Divider(),
              Text(
                'Cus:Name: ${orderModel.CustomerName}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Cus:Id: ${orderModel.CustomerId}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Cus:Phone#: ${orderModel.CustomerPhoneNumber}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Cus:Address: ${orderModel.CustomerAddress}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Billing Detail\'s',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pd:Name: ${orderModel.ProductName}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FittedBox(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        orderModel.ProductImg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Pd:Description: ${orderModel.ProductDescription}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Pd:Quantity: ${orderModel.ProductQuantity}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Pd:TotalPrice: ${orderModel.ProductTotalPrice}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.red,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Alert! Change Order Status',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'please wait');
                      await FirebaseFirestore.instance
                          .collection('Order')
                          .doc(userid)
                          .collection('ConformOrder')
                          .doc(orderid)
                          .update({'Status': false});
                      print('status updated${orderid}');
                      EasyLoading.dismiss();
                    },
                    child: Text(
                      'Pending',
                      style: TextStyle(color: AppConstant.textColor),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'please wait');
                      await FirebaseFirestore.instance
                          .collection('Order')
                          .doc(userid)
                          .collection('ConformOrder')
                          .doc(orderid)
                          .update({'Status': true});
                      print('status updated${orderid}');
                      EasyLoading.dismiss();
                    },
                    child: Text(
                      'Delivered',
                      style: TextStyle(color: AppConstant.textColor),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
