import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class AppleFailedScreen extends StatefulWidget {
  const AppleFailedScreen({super.key});

  @override
  State<AppleFailedScreen> createState() => _AppleFailedScreenState();
}

class _AppleFailedScreenState extends State<AppleFailedScreen> {
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
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(failed), fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomWidgets.text('Payment Failed', fontSize: 16.sp, fontWeight: FontWeight.w800, color: CustomColor.btn),
                SizedBox(
                  height: 5.h,
                ),
                CustomWidgets.text('Payment has been processed to Failed \nPlease Try again later.',
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
