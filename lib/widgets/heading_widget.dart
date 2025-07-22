import 'package:flutter/material.dart';

import 'package:thegarments/utils/app_constant.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubtitle;
  final VoidCallback ontap;
  final String buttonText;
  const HeadingWidget(
      {super.key,
      required this.headingTitle,
      required this.headingSubtitle,
      required this.buttonText,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headingTitle,
                style: TextStyle(
                    color: AppConstant.textColor, fontWeight: FontWeight.bold),
              ),
              Text(
                headingSubtitle,
                style: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: AppConstant.secondaryColor, width: 2)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: ontap,
                child: Text(
                  buttonText,
                  style: TextStyle(
                      color: AppConstant.secondaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
