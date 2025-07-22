import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:thegarments/controller/get_user_data_controller.dart';
import 'package:thegarments/screens/admin_panel/admin_main_screen.dart';
import 'package:thegarments/screens/auth_ui/login_screen.dart';
import 'package:thegarments/screens/user_panel/main_screen.dart';

import 'package:thegarments/utils/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? _user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      keeplogin(context);
      Get.offAll(() => LoginScreen());
    });
  }

  Future<void> keeplogin(BuildContext context) async {
    if (_user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var Userdata = await getUserDataController.getuserdataMethod(_user!.uid);
      if (Userdata[0]['isAdmin'] == true) {
        Get.off(() => AdminMainScreen());
      } else {
        Get.off(() => MainScreen());
      }
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.primeryColor,
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Container(
            child: Lottie.asset('assets/images/Animation - 1741986280802.json'),
          ),
          Container(
            child: Text(
              'The Garments',
              style: TextStyle(
                  color: AppConstant.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
          ),
          SizedBox(
            height: 300,
          ),
          Container(
            child: Text(
              AppConstant.poweredBy,
              style: TextStyle(
                  color: AppConstant.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
