import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thegarments/screens/auth_ui/login_screen.dart';
import 'package:thegarments/screens/user_panel/main_screen.dart';
import 'package:thegarments/screens/user_panel/user_orders_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class UserAppDrawer extends StatefulWidget {
  const UserAppDrawer({super.key});

  @override
  State<UserAppDrawer> createState() => _UserAppDrawerState();
}

class _UserAppDrawerState extends State<UserAppDrawer> {
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
                  'User',
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
                  child: Text('U'),
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
                    Get.offAll(() => MainScreen());
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
                onTap: () => Get.to(() => UserOrdersScreen()),
                child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'My Orders',
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
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    'Contact',
                    style: TextStyle(
                        color: AppConstant.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.help,
                    color: AppConstant.textColor,
                  )),
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
