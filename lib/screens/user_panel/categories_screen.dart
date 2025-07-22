import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_card/image_card.dart';
import 'package:thegarments/models/categories_model.dart';
import 'package:thegarments/screens/user_panel/cart_screen.dart';
import 'package:thegarments/screens/user_panel/single_category_product_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
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
        future: FirebaseFirestore.instance.collection('Categories').get(),
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
              var categoryData = snapshot.data!.docs[index];
              CategoriesModel categoriesModel = CategoriesModel(
                CategoryId: categoryData['CategoryId'],
                CategoryImg: categoryData['CategoryImg'],
                CategoryName: categoryData['CategoryName'],
                CreatedAt: categoryData['CreatedAt'],
                UpdatedAt: categoryData['UpdatedAt'],
              );

              return GestureDetector(
                onTap: () {
                  Get.to(() => SingleCategoryProductScreen(
                      categoriesModel.CategoryId,
                      categoriesModel.CategoryName));
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FillImageCard(
                    width: 200,
                    heightImage: 150,
                    imageProvider:
                        CachedNetworkImageProvider(categoriesModel.CategoryImg),
                    title: Center(
                      child: Text(
                        categoriesModel.CategoryName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
