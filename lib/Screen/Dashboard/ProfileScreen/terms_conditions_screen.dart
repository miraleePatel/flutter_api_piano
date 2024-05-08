import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Controller/profile_controller.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/string_constants.dart';
import '../../../Widget/custom_widget.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.termsConditionApi();
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
          body: Stack(
            children: [
              Image.asset(backgroundImage),
              Column(
                children: [
                  CustomWidgets.CustAppbar(
                    title: "Terms & Conditions",
                  ),
                  Obx(
                    () {
                       // no internet connection
                      return isInternetAvailable.value == true
                          ? CustomWidgets.customContainer(
                              margintop: 0.h,
                              top: 14.h,
                              height: 80.h,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      profileController
                                                  .termsConData.value.data !=
                                              null
                                          ? CustomWidgets.text(
                                              profileController
                                                  .termsConData.value.data
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              fontSize: 11.sp,
                                            )
                                          : Container(),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                           : CustomWidgets.NoInertnet(top: 200);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
