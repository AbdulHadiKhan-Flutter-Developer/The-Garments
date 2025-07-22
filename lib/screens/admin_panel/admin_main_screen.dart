import 'package:flutter/material.dart';

import 'package:thegarments/utils/app_constant.dart';
import 'package:thegarments/widgets/admin_app_drawer.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.primeryColor,
        centerTitle: true,
        title: Text('Admin Screen'),
      ),
      drawer: AdminAppDrawer(),
    );
  }
}
