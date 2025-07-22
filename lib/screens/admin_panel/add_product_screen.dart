// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegarments/controller/add_image_controller.dart';
import 'package:thegarments/utils/app_constant.dart';

class AddProductScreen extends StatelessWidget {
  AddImageController addImageController = Get.put(AddImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Product\'s'),
      ),
      body: Column(
        children: [
          Center(
              child: IconButton(
                  onPressed: () {
                    addImageController.showimagepickerdialog();
                  },
                  icon: Icon(
                    Icons.image,
                    size: 100,
                  ))),
          Text('Select Image'),
          GetBuilder<AddImageController>(
            builder: (imagecontroller) {
              return imagecontroller.selectedimage.length < 0
                  ? Container(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 3,
                                  crossAxisSpacing: 3,
                                  childAspectRatio: 1 / 1.2),
                          itemCount: addImageController.selectedimage.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Image.file(
                                  File(addImageController
                                      .selectedimage[index].path),
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  child: InkWell(
                                    //for deleting
                                    onTap: () {
                                      addImageController.removeimage(index);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          AppConstant.secondaryColor,
                                      child: Icon(
                                        Icons.close,
                                        color: AppConstant.textColor,
                                      ),
                                    ),
                                  ),
                                  right: 10,
                                  top: 0,
                                )
                              ],
                            );
                          }),
                    )
                  : SizedBox.shrink();
            },
            init: AddImageController(),
          )
        ],
      ),
    );
  }
}
