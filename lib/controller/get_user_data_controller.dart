import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getuserdataMethod(
      String uId) async {
    final QuerySnapshot userdata = await _firebaseFirestore
        .collection('Users')
        .where('uId', isEqualTo: uId)
        .get();
    return userdata.docs;
  }
}
