import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannerurls = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();
    bannerUrlsfetchingMethod();
  }

  Future<void> bannerUrlsfetchingMethod() async {
    try {
      QuerySnapshot bannerSnapshot =
          await FirebaseFirestore.instance.collection('Banners').get();
      if (bannerSnapshot.docs.isNotEmpty) {
        bannerurls.value = bannerSnapshot.docs
            .map((doc) => doc['imageurl'] as String)
            .toList();
      }
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }
}
