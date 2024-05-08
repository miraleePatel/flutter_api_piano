import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class AppleSuccessfullScreen extends StatefulWidget {
  const AppleSuccessfullScreen({super.key});

  @override
  State<AppleSuccessfullScreen> createState() => _AppleSuccessfullScreenState();
}

class _AppleSuccessfullScreenState extends State<AppleSuccessfullScreen> {
  @override
  void initState() {
    Timer(
      const Duration(
        seconds: 8,
      ),
      () => Get.offAllNamed(Routes.DASHBOARD_SCREEN),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: CustomColor.btnAbout,
          body: Container(
            width: 100.w,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(successful), fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomWidgets.text('Pay Successfully', fontSize: 16.sp, fontWeight: FontWeight.w800, color: CustomColor.btn),
                SizedBox(
                  height: 5.h,
                ),
                CustomWidgets.text('Payment has been processed successfully.\n Thank you for your transaction.',
                    fontSize: 13.sp, textAlign: TextAlign.center, color: CustomColor.btn),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 3.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
