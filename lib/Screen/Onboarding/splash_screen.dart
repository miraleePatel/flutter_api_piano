import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(
        seconds: 3,
      ),
      () => Get.offAllNamed(Routes.DASHBOARD_SCREEN),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: CustomColor.btnAbout,
          body: Stack(
            children: [
              Image.asset(
                backgroundImage,
              ),
              Center(
                child: Image.asset(
                  logo,
                  scale: SizerUtil.deviceType == DeviceType.mobile ? 2.3 : 1.3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
