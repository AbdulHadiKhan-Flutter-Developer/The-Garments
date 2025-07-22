// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddImageController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  final RxList<XFile> selectedimage = <XFile>[].obs;
  final RxList<String> selectedimageurl = <String>[].obs;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> showimagepickerdialog() async {
    PermissionStatus permissionStatus;
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    if (androidDeviceInfo.version.sdkInt <= 32) {
      permissionStatus = await Permission.storage.request();
    } else {
      permissionStatus = await Permission.mediaLibrary.request();
    }
    if (permissionStatus == PermissionStatus.granted) {
      Get.defaultDialog(
        title: 'Select Image',
        middleText: 'Selece Image form Camera Or Gallery',
        actions: [
          ElevatedButton(
              onPressed: () {
                selectedimageformdevice('Camera');
              },
              child: Text('Camera')),
          ElevatedButton(
              onPressed: () {
                selectedimageformdevice('Gallery');
              },
              child: Text('Gallery'))
        ],
      );
    }
    if (permissionStatus == PermissionStatus.denied) {
      openAppSettings();
    }
    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> selectedimageformdevice(String type) async {
    List<XFile> imgs = [];
    if (type == 'Camera') {
      imgs = await imagePicker.pickMultiImage(imageQuality: 80);
    } else {
      if (type == 'Gallery') {
        imgs = await imagePicker.pickMultiImage(imageQuality: 80);
      }
    }
    if (imgs != null) {
      selectedimage.addAll(imgs);
      update();
    }
  }

 void removeimage(int index) {
    selectedimage.removeAt(index);
    update();
  }
}
