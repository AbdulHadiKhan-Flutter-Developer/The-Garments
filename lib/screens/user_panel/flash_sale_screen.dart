import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:thegarments/models/products_model.dart';
import 'package:thegarments/screens/user_panel/cart_screen.dart';
import 'package:thegarments/screens/user_panel/single_flash_sale_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class FlashSaleScreen extends StatelessWidget {
  const FlashSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flash Sale'),
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
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Products')
              .where('issale', isEqualTo: true)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Something Wen\'t Wrong'),
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
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Container(
                child: Center(
                  child: Text('No sale Product\'s Found'),
                ),
              );
            }
            return GestureDetector(
              onTap: () {},
              child: GridView.builder(
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
                    onTap: () =>
                        Get.to(() => SingleFlashSaleScreen(productsModel)),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FillImageCard(
                        width: 200,
                        heightImage: 130,
                        imageProvider: CachedNetworkImageProvider(
                            productsModel.ProductImg),
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
                              width: 4,
                            ),
                            Text(
                              productsModel.FullPrice,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppConstant.secondaryColor),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.favorite_border,
                              color: AppConstant.secondaryColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: AppConstant.secondaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
