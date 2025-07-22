import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:thegarments/screens/admin_panel/admin_main_screen.dart';
import 'package:thegarments/screens/admin_panel/all_orders.dart';
import 'package:thegarments/screens/admin_panel/all_products.dart';
import 'package:thegarments/screens/admin_panel/all_user_screen.dart';
import 'package:thegarments/screens/auth_ui/login_screen.dart';

import 'package:thegarments/utils/app_constant.dart';

class AdminAppDrawer extends StatefulWidget {
  @override
  State<AdminAppDrawer> createState() => _AdminAppDrawerState();
}

class _AdminAppDrawerState extends State<AdminAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35),
      child: Drawer(
        backgroundColor: AppConstant.primeryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Admin',
                  style: TextStyle(
                      color: AppConstant.textColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Version 1.1.0',
                  style: TextStyle(color: AppConstant.textColor),
                ),
                leading: CircleAvatar(
                  backgroundColor: AppConstant.secondaryColor,
                  radius: 40,
                  child: Text('A'),
                ),
              ),
            ),
            Divider(
              color: AppConstant.textColor,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  onTap: () {
                    Get.offAll(() => AdminMainScreen());
                  },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    'Home',
                    style: TextStyle(
                        color: AppConstant.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: AppConstant.textColor,
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: GestureDetector(
                onTap: () => Get.to(() => AllProducts()),
                child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'Products',
                      style: TextStyle(
                          color: AppConstant.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.production_quantity_limits,
                      color: AppConstant.textColor,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: GestureDetector(
                onTap: () => Get.to(() => AllUserScreen()),
                child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'Users',
                      style: TextStyle(
                          color: AppConstant.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.person,
                      color: AppConstant.textColor,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: GestureDetector(
                onTap: () => Get.to(() => AllOrders()),
                child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'Order',
                      style: TextStyle(
                          color: AppConstant.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.shopping_bag,
                      color: AppConstant.textColor,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  onTap: () {
                    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                    firebaseAuth.signOut();
                    GoogleSignIn googleSignIn = GoogleSignIn();

                    googleSignIn.signOut();

                    Get.offAll(() => LoginScreen());
                  },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: AppConstant.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: AppConstant.textColor,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
