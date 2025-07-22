// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:thegarments/controller/get_user_data_controller.dart';
import 'package:thegarments/controller/google_signin_controller.dart';
import 'package:thegarments/controller/signin_controller.dart';
import 'package:thegarments/screens/admin_panel/admin_main_screen.dart';
import 'package:thegarments/screens/auth_ui/forgot_screen.dart';
import 'package:thegarments/screens/auth_ui/signup_screen.dart';
import 'package:thegarments/screens/user_panel/main_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSigninController _googleSigninController =
      Get.put(GoogleSigninController());
  final GetUserDataController _getUserDataController =
      Get.put(GetUserDataController());
  SigninController signinController = Get.put(SigninController());
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.primeryColor,
          elevation: 0,
          title: Text(
            'SignIn',
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
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Obx(
                    () => TextFormField(
                      controller: userpasswordController,
                      cursorColor: AppConstant.primeryColor,
                      obscureText: signinController.isPasswordVisible.value,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.all(3),
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                signinController.isPasswordVisible.toggle();
                              },
                              child: signinController.isPasswordVisible.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(() => ForgotScreen());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: AppConstant.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String email = useremailController.text.trim();
                    String password = userpasswordController.text.trim();
                    String userDeviceToken = '';

                    if (email.isEmpty || password.isEmpty) {
                      Get.snackbar('Error', 'Please Enter All Details',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.primeryColor,
                          colorText: AppConstant.textColor);
                    } else {
                      UserCredential? userCredential = await signinController
                          .signinMethod(email, password, userDeviceToken);
                      var Userdata = await _getUserDataController
                          .getuserdataMethod(userCredential!.user!.uid);
                      if (userCredential != null) {
                        if (userCredential.user!.emailVerified) {
                          if (Userdata[0]['isAdmin'] == true) {
                            Get.snackbar('Success', 'Admin login successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.primeryColor,
                                colorText: AppConstant.textColor);
                            Get.offAll(() => AdminMainScreen());
                          } else {
                            Get.offAll(() => MainScreen());
                            Get.snackbar('Success', 'Login successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.primeryColor,
                                colorText: AppConstant.textColor);
                          }
                        } else {
                          Get.snackbar(
                              'Error', 'Please Verify your email before login!',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.primeryColor,
                              colorText: AppConstant.textColor);
                        }
                      }
                    }
                  },
                  child: Text(
                    'SignIn',
                    style: TextStyle(color: AppConstant.textColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.primeryColor),
                ),
                SizedBox(height: 20),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      _googleSigninController.signingwithgoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(AssetImage(
                          'assets/images/google_logo.png',
                        )),
                        Text(
                          'SignIn with Google',
                          style: TextStyle(
                              color: AppConstant.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.primeryColor,
                    ),
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(() => SignupScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: AppConstant.textColor),
                        ),
                        Text(
                          'SignUp',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppConstant.secondaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
