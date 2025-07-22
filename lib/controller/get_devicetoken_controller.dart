import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:thegarments/utils/app_constant.dart';

class GetDevicetokenController extends GetxController {
  String? deviceToken;
  @override
  void onInit() {
    super.onInit();
    getdevicetokenMethod();
  }

  Future<void> getdevicetokenMethod() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        deviceToken = token;
        update();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.primeryColor,
          colorText: AppConstant.textColor);
    }
  }
}
