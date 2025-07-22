// ignore_for_file: unused_field, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thegarments/controller/get_devicetoken_controller.dart';
import 'package:thegarments/models/user_model.dart';
import 'package:thegarments/screens/user_panel/main_screen.dart';

class GoogleSigninController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signingwithgoogle() async {
    final GetDevicetokenController getDevicetokenController =
        Get.put(GetDevicetokenController());
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        EasyLoading.show(status: 'Please Wait');
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(authCredential);

        final User? user = userCredential.user;
        if (user != null) {
          UserModel userModel = UserModel(
              uId: user.uid,
              username: user.displayName.toString(),
              email: user.email.toString(),
              phone: user.phoneNumber.toString(),
              userImage: user.photoURL.toString(),
              userDeviceToken: getDevicetokenController.deviceToken.toString(),
              country: '',
              userAddress: '',
              street: '',
              isAdmin: false,
              isActive: true,
              createdOn: DateTime.now());
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .set(userModel.toMap());
          EasyLoading.dismiss();
          Get.offAll(() => MainScreen());
        }
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      print('Error: $e');
    }
  }
}
