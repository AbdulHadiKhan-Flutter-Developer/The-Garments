// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_card/image_card.dart';

import 'package:thegarments/models/products_model.dart';
import 'package:thegarments/screens/user_panel/single_category_detail_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class SingleCategoryProductScreen extends StatelessWidget {
  final categoryId;
  final categoryName;
  SingleCategoryProductScreen(this.categoryId, this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
        backgroundColor: AppConstant.primeryColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Products')
            .where('CategoryId', isEqualTo: categoryId)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Category Found"));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1 / 1.2),
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var productData = snapshot.data!.docs[index];
              ProductsModel productsModel = ProductsModel(
                  ProductId: productData['ProductId'],
                  CategoryId: productData['CategoryId'],
                  ProductName: productData['ProductName'],
                  CategoryName: productData['CategoryId'],
                  SalePrice: productData['SalePrice'],
                  FullPrice: productData['FullPrice'],
                  ProductImg: productData['ProductImg'],
                  DeliveryTime: productData['DeliveryTime'],
                  issale: productData['issale'],
                  ProductDescription: productData['ProductDescription'],
                  CreatedAt: productData['CreatedAt'],
                  UpdatedAt: productData['UpdatedAt']);

              return GestureDetector(
                onTap: () {
                  Get.to(() => SingleCategoryDetailScreen(productsModel));
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FillImageCard(
                    width: 220,
                    heightImage: 140,
                    imageProvider:
                        CachedNetworkImageProvider(productsModel.ProductImg),
                    title: Center(
                      child: Text(
                        productsModel.ProductName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    footer: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        productsModel.issale == true &&
                                productsModel.issale != ''
                            ? Text(
                                'Rs: ${productsModel.SalePrice}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            : Text(
                                'Rs: ${productsModel.FullPrice}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                        SizedBox(width: 50),
                        Icon(
                          Icons.favorite_border,
                          size: 22,
                          color: AppConstant.secondaryColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 22,
                          color: AppConstant.secondaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
