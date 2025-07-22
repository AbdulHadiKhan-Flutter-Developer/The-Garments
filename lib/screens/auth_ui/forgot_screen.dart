import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:thegarments/controller/forgot_password_controller.dart';
import 'package:thegarments/screens/auth_ui/login_screen.dart';

import 'package:thegarments/utils/app_constant.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController useremailController = TextEditingController();
  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.primeryColor,
          elevation: 0,
          title: Text(
            'Forgot Password',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                isKeyboardVisible
                    ? SizedBox.shrink()
                    : Container(
                        color: AppConstant.primeryColor,
                        child: Lottie.asset(
                            'assets/images/Animation - 1741986280802.json'),
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Happy Shopping',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: useremailController,
                    cursorColor: AppConstant.primeryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding: EdgeInsets.all(3),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    String email = useremailController.text.trim();
                    if (email.isEmpty) {
                      Get.snackbar('Error', 'Please Enter All Details',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.primeryColor,
                          colorText: AppConstant.textColor);
                    } else {
                      forgotPasswordController.forgotpasswordMethod(email);
                      Get.offAll(() => LoginScreen());
                    }
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: AppConstant.textColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.primeryColor),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
