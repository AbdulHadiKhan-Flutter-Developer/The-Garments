// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegarments/controller/get_user_length_controller.dart';
import 'package:thegarments/models/user_model.dart';
import 'package:thegarments/utils/app_constant.dart';

class AllUserScreen extends StatelessWidget {
  final GetUserLengthController getUserLengthController =
      Get.put(GetUserLengthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.primeryColor,
          title: Obx(() {
            return Text(
                'All User\'s (${getUserLengthController.totaluserlength.toString()})');
          })),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where('isAdmin', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Some error occured'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot == null || snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('User\'s Section is Empty'),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              var userdata = snapshot.data!.docs[index];
              UserModel userModel = UserModel(
                  uId: userdata['uId'],
                  username: userdata['username'],
                  email: userdata['email'],
                  phone: userdata['phone'],
                  userImage: userdata['userImage'],
                  userDeviceToken: userdata['userDeviceToken'],
                  country: userdata['country'],
                  userAddress: userdata['userAddress'],
                  street: userdata['street'],
                  isAdmin: userdata['isAdmin'],
                  isActive: userdata['isActive'],
                  createdOn: userdata['createdOn']);
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(userModel.username[0]),
                    backgroundColor: AppConstant.secondaryColor,
                  ),
                  title: Text(userModel.username),
                  subtitle: Row(
                    children: [
                      Text(userModel.email),
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
          );
        },
      ),
    );
  }
}
