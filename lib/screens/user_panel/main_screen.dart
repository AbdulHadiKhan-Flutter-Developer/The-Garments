import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegarments/screens/user_panel/all_products_screen.dart';
import 'package:thegarments/screens/user_panel/cart_screen.dart';
import 'package:thegarments/screens/user_panel/categories_screen.dart';
import 'package:thegarments/screens/user_panel/flash_sale_screen.dart';

import 'package:thegarments/utils/app_constant.dart';
import 'package:thegarments/widgets/all_products_widget.dart';
import 'package:thegarments/widgets/banner_widget.dart';
import 'package:thegarments/widgets/categories_widget.dart';
import 'package:thegarments/widgets/heading_widget.dart';
import 'package:thegarments/widgets/flash_sale_widget.dart';
import 'package:thegarments/widgets/user_app_drawer.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.primeryColor,
        centerTitle: true,
        title: Text('The Garments'),
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
      drawer: UserAppDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              BannerWidget(),
              HeadingWidget(
                  headingTitle: 'Categories',
                  headingSubtitle: 'According to your style!',
                  buttonText: 'See More >',
                  ontap: () => Get.to(() => CategoriesScreen())),
              CategoriesWidget(),
              HeadingWidget(
                  headingTitle: 'Flash Sale',
                  headingSubtitle: 'Shop the Latest Trends!',
                  buttonText: 'See More >',
                  ontap: () {
                    Get.to(() => FlashSaleScreen());
                  }),
              FlashSaleWidget(),
              HeadingWidget(
                  headingTitle: 'Our Collection',
                  headingSubtitle: 'All Products in One Place!',
                  buttonText: 'See More >',
                  ontap: () {
                    Get.to(() => AllProductsScreen());
                  }),
              AllProductsWidget()
            ],
          ),
        ),
      ),
    );
  }
}
