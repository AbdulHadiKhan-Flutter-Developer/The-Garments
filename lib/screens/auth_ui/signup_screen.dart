import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:thegarments/controller/signup_controller.dart';
import 'package:thegarments/screens/auth_ui/login_screen.dart';
import 'package:thegarments/utils/app_constant.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController _signupController = Get.put(SignupController());
  TextEditingController usernameController = TextEditingController();
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
            'SignUp',
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
                    controller: usernameController,
                    cursorColor: AppConstant.primeryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'User Name',
                        contentPadding: EdgeInsets.all(3),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                      obscureText: _signupController.isPasswordVisible.value,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.all(3),
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                _signupController.isPasswordVisible.toggle();
                              },
                              child: _signupController.isPasswordVisible.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String name = usernameController.text.trim();
                    String email = useremailController.text.trim();
                    String password = userpasswordController.text.trim();
                    String userDeviceToken = '';

                    if (name.isEmpty || email.isEmpty || password.isEmpty) {
                      Get.snackbar('Error', 'Please Enter All Details');
                    } else {
                      UserCredential? userCredential = await _signupController
                          .signupMethod(name, email, password, userDeviceToken);
                      if (userCredential != null) {
                        Get.snackbar('Verification Email Sent',
                            'Please Check Your Email',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.primeryColor,
                            colorText: AppConstant.textColor);
                        FirebaseAuth.instance.signOut();
                        Get.offAll(() => LoginScreen());
                      }
                    }
                  },
                  child: Text(
                    'SignUp',
                    style: TextStyle(color: AppConstant.textColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.primeryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(() => LoginScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: AppConstant.textColor),
                        ),
                        Text(
                          'SignIn',
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
