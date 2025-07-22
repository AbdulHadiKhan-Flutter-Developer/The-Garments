import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserLengthController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      streamSubscription;

  final Rx<int> totaluserlength = Rx<int>(0);

  @override
  void onInit() {
    super.onInit();
    streamSubscription = firebaseFirestore
        .collection('Users')
        .where('isAdmin', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      totaluserlength.value = snapshot.size;
    });
  }

  @override
  void onClose() {
    super.onClose();
    streamSubscription.cancel();
  }
}
