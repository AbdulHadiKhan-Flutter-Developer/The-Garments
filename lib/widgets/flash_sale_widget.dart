// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:image_card/image_card.dart';

import 'package:thegarments/models/products_model.dart';
import 'package:thegarments/screens/user_panel/single_flash_sale_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class FlashSaleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('Products')
          .where('issale', isEqualTo: true)
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

        return SizedBox(
          height: 150, // Ensures ListView has a defined height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
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
                onTap: () => Get.to(() => SingleFlashSaleScreen(productsModel)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FillImageCard(
                    width: 125,
                    heightImage: 70,
                    imageProvider: CachedNetworkImageProvider(
                      productsModel.ProductImg,
                    ),
                    title: Center(
                      child: Text(
                        productsModel.ProductName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    footer: Row(
                      children: [
                        Text(
                          'Rs ${productsModel.SalePrice}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          productsModel.FullPrice,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppConstant.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
