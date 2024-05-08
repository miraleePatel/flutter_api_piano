// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Utils/app_color.dart';
import 'custom_widget.dart';

class CustomButton extends StatelessWidget {
  String text;
  void Function() onPressed;
  double? width;
  Color? color;
  Color? bordercolor;
  CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.color,
    this.bordercolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 6.h,
        width: width,
        decoration: BoxDecoration(
          color: color ?? CustomColor.btn,
          borderRadius: BorderRadius.circular(
            8.sp,
          ),
          border: Border.all(
            color: bordercolor ?? CustomColor.btnBorder,
          ),
        ),
        child: Center(
          child: CustomWidgets.text(
            text,
            color: CustomColor.textBtn,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
