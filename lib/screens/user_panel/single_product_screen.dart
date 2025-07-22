// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thegarments/models/cart_model.dart';
import 'package:thegarments/models/products_model.dart';
import 'package:thegarments/screens/user_panel/cart_screen.dart';
import 'package:thegarments/utils/app_constant.dart';
import 'package:thegarments/widgets/add_to_cart_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleProductScreen extends StatelessWidget {
  final ProductsModel productmodel;

  SingleProductScreen(this.productmodel);

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Collection\'s'),
        centerTitle: true,
        backgroundColor: AppConstant.primeryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Get.to(() => CartScreen()),
              child: Icon(
                Icons.shopping_cart,
                color: AppConstant.textColor,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 280,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: productmodel.ProductImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            productmodel.ProductName,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                                color: AppConstant.textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                          ),
                        ),
                        Icon(
                          Icons.favorite_border_outlined,
                          size: 30,
                          color: AppConstant.secondaryColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Pkr: ${productmodel.FullPrice}',
                      style: TextStyle(
                          color: AppConstant.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Category: ${productmodel.CategoryName}',
                      style: TextStyle(
                          color: AppConstant.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description: ${productmodel.ProductDescription}',
                      style: TextStyle(
                          color: AppConstant.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Chip(
                  shadowColor: AppConstant.secondaryColor,
                  label: Text('Total: ${productmodel.FullPrice}-pkr ')),
              ElevatedButton(
                onPressed: () {
                  sendmessageonwhatsapp(productmodel: productmodel);
                },
                child: Text(
                  'WhatsApp',
                  style: TextStyle(
                      color: AppConstant.textColor,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.secondaryColor),
              ),
              ElevatedButton(
                onPressed: () async {
                  await AddToCartWidget(
                      UId: user!.uid, productmodel: productmodel);
                  Get.snackbar('Success', 'Item Added Successfully',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppConstant.primeryColor,
                      colorText: AppConstant.textColor);
                },
                child: Text(
                  'Add to cart',
                  style: TextStyle(
                      color: AppConstant.textColor,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.primeryColor),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> sendmessageonwhatsapp(
      {required ProductsModel productmodel}) async {
    final number = '+923219211529';
    final message =
        'Hello Hoor Garments I want to know about ${productmodel.ProductName}';
    final url = 'https://wa.me/$number?text-${Uri.encodeComponent(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<void> checkexistingproduct({UId, int quantityincrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Cart')
        .doc(UId)
        .collection('CartItem')
        .doc(productmodel.ProductId);

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentquantity = snapshot['ProductQuantity'];
      int updatedquantity = currentquantity + quantityincrement;
      double totalPrice = double.parse(productmodel.issale
              ? productmodel.SalePrice
              : productmodel.FullPrice) *
          updatedquantity;
      await documentReference.update({
        'ProductQuantity': updatedquantity,
        'ProductTotalPrice': totalPrice
      });
      print('Product Exist');
    } else {
      await FirebaseFirestore.instance.collection('Cart').doc(UId).set({
        'UId': UId,
        'CreatedAt': DateTime.now(),
      });
      CartModel cartModel = CartModel(
        ProductId: productmodel.ProductId,
        CategoryId: productmodel.CategoryId,
        ProductName: productmodel.ProductName,
        CategoryName: productmodel.CategoryName,
        SalePrice: productmodel.SalePrice,
        FullPrice: productmodel.FullPrice,
        ProductImg: productmodel.ProductImg,
        DeliveryTime: productmodel.DeliveryTime,
        issale: productmodel.issale,
        ProductDescription: productmodel.ProductDescription,
        CreatedAt: DateTime.now(),
        UpdatedAt: DateTime.now(),
        ProductQuantity: 1,
        ProductTotalPrice: double.parse(productmodel.issale
            ? productmodel.SalePrice
            : productmodel.FullPrice),
      );

      await documentReference.set(
        cartModel.toMap(),
      );
    }
  }
}
