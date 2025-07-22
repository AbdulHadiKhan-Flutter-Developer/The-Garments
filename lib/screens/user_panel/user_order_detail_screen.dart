// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:thegarments/models/order_model.dart';

class UserOrderDetailScreen extends StatelessWidget {
  OrderModel orderModel;

  UserOrderDetailScreen({
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order detail\'s'),
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
                  'Your Detail\'s',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            Divider(),
            Text(
              'Your:Name: ${orderModel.CustomerName}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),

            Text(
              'Your:Phone#: ${orderModel.CustomerPhoneNumber}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Your:Address: ${orderModel.CustomerAddress}',
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
              height: 40,
            ),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Get.to(() => UserOrdersScreen());
            //     },
            //     child: Text(
            //       'Done',
            //       style: TextStyle(color: AppConstant.textColor),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppConstant.secondaryColor,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
