// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SubtotalController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  RxDouble subtotal = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchsubtotal();
  }

  void fetchsubtotal() async {
    final QuerySnapshot<Map<String, dynamic>> documentsnapshot =
        await FirebaseFirestore.instance
            .collection('Cart')
            .doc(user!.uid)
            .collection('CartItem')
            .get();
    double sum = 0.0;
    for (final doc in documentsnapshot.docs) {
      final price = doc.data();
      if (price != null || price.containsKey('ProductTotalPrice')) {
        sum += (price['ProductTotalPrice'] as num);
      }
    }
    subtotal.value = sum;
  }
}
