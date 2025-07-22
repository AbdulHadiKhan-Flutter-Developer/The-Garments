// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegarments/models/products_model.dart';
import 'package:thegarments/screens/admin_panel/add_product_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.primeryColor,
        title: Text('All Product\'s'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .orderBy('CreatedAt', descending: true)
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
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot == null || snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No Product\'s Found'),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              var productdata = snapshot.data!.docs[index];
              ProductsModel productsModel = ProductsModel(
                  ProductId: productdata['ProductId'],
                  CategoryId: productdata['CategoryId'],
                  ProductName: productdata['ProductName'],
                  CategoryName: productdata['CategoryName'],
                  SalePrice: productdata['SalePrice'],
                  FullPrice: productdata['FullPrice'],
                  ProductImg: productdata['ProductImg'],
                  DeliveryTime: productdata['DeliveryTime'],
                  issale: productdata['issale'],
                  ProductDescription: productdata['ProductDescription'],
                  CreatedAt: productdata['CreatedAt'],
                  UpdatedAt: productdata['UpdatedAt']);
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(productsModel.ProductImg),
                  ),
                  title: Text(productsModel.ProductName),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CreatedAt: ${productsModel.CreatedAt}',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                      Text(
                        'UpdatedAt: ${productsModel.UpdatedAt}',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConstant.secondaryColor,
        onPressed: () {
          Get.to(() => AddProductScreen());
        },
        child: Icon(
          Icons.add,
          color: AppConstant.textColor,
        ),
      ),
    );
  }
}
