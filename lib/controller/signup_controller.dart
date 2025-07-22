// ignore_for_file: unused_field, body_might_complete_normally_nullable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:thegarments/controller/get_devicetoken_controller.dart';
import 'package:thegarments/models/user_model.dart';
import 'package:thegarments/utils/app_constant.dart';

class SignupController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //password visibility...
  var isPasswordVisible = false.obs;

// SignUp Method...

  Future<UserCredential?> signupMethod(String userName, String email,
      String password, String userDeviceToken) async {
    final GetDevicetokenController getDevicetokenController =
        Get.put(GetDevicetokenController());
    try {
      EasyLoading.show(status: 'Please Wait');
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          username: userName,
          email: email,
          phone: '',
          userImage: 'userImage',
          userDeviceToken: userDeviceToken =
              getDevicetokenController.deviceToken.toString(),
          country: '',
          userAddress: '',
          street: '',
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now());
      _firebaseFirestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Warning!', '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.primeryColor,
          colorText: AppConstant.textColor);
    }
  }
}
