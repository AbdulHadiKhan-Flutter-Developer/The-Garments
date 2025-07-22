import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getcustomerdevicetoken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      return token;
    } else {
      throw Exception('Some thing wen\'t wrong');
    }
  } on FirebaseAuthException catch (e) {
    print('Error: $e');
    throw Exception('Some thing wen\'t wrong');
  }
}
