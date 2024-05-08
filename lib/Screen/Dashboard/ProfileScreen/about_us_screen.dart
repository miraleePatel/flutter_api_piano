// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Controller/profile_controller.dart';
import '../../../Utils/app_color.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.aboutUsDataApi();
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
                    title: "About Us",
                  ),
                  Obx(
                    () {
                      // No internet connection
                      return isInternetAvailable.value == true
                          ? profileController.aboutUsDetails.value.status == 1
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    CustomWidgets.customContainer(
                                      margintop: 0.h,
                                      top: 14.h,
                                      height: 70.h,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 5.w, left: 5.w),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              CustomWidgets.text(
                                                profileController.aboutUsDetails
                                                    .value.data!.desc1
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                fontSize: 10.sp,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              CustomWidgets.text(
                                                profileController.aboutUsDetails
                                                    .value.data!.desc2
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                fontSize: 10.sp,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              CustomWidgets.text(
                                                profileController.aboutUsDetails
                                                    .value.data!.desc3
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                fontSize: 10.sp,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              CustomWidgets.text(
                                                profileController.aboutUsDetails
                                                    .value.data!.desc4
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                fontSize: 10.sp,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    CustomWidgets.text(
                                      profileController
                                          .aboutUsDetails.value.data!.linkTitle
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w800,
                                      color: CustomColor.btn,
                                      fontSize: 10.sp,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var url = profileController
                                            .aboutUsDetails.value.data!.link
                                            .toString(); // Replace with your website URL

                                        await launch(url,
                                            forceSafariVC: false,
                                            universalLinksOnly: false);
                                      },
                                      child: CustomWidgets.text(
                                          profileController
                                              .aboutUsDetails.value.data!.link
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          fontSize: 10.sp,
                                          color: Colors.blue),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                  ],
                                )
                              : Container()
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
