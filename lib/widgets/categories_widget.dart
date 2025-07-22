// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:image_card/image_card.dart';
import 'package:thegarments/models/categories_model.dart';
import 'package:thegarments/screens/user_panel/single_category_product_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

        return SizedBox(
          height: 130, // Ensures ListView has a defined height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
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
                    width: 100,
                    heightImage: 70,
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
          ),
        );
      },
    );
  }
}
