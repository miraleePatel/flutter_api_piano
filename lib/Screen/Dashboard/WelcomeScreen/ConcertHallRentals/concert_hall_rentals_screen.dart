// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Controller/welcome_controller.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:piano_project/Utils/constant_widgets.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/authetication_controller.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class ConsertHallRentalsScreen extends StatefulWidget {
  const ConsertHallRentalsScreen({Key? key}) : super(key: key);

  @override
  State<ConsertHallRentalsScreen> createState() => _ConsertHallRentalsScreenState();
}

class _ConsertHallRentalsScreenState extends State<ConsertHallRentalsScreen> {
  final WelcomeController welcomeController = Get.put(WelcomeController());
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    welcomeController.getAllConcertCategoryApi();
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
              Image.asset(
                backgroundImage,
              ),
              Column(
                children: [
                  // CustomWidgets.CustAppbar(
                  //   title: "Concert Hall Rental",
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 1.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back(closeOverlays: true, result: true);
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, color: CustomColor.btn, size: SizerUtil.deviceType == DeviceType.mobile ? 20 : 30),
                        ),
                        CustomWidgets.text(
                          "Concert Hall Rental",
                          fontWeight: FontWeight.w800,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 15.sp : 12.sp,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              bool isCheck = getVerifyStatus();

                              print('isCheck ::: $isCheck');

                              if (getAuthToken() == "") {
                                Get.toNamed(
                                  Routes.LOGIN_SCREEN,
                                );
                              } else {
                                Get.toNamed(Routes.CONCERT_HALL_BOOK_SCREEN);
                              }
                            },
                            child: SizedBox(
                              width: 9.w,
                              child: Image.asset(
                                bookhistory,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                      ),
                      child: SingleChildScrollView(
                        child: Obx(
                          () {
                            return isInternetAvailable.value == true
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      CustomWidgets.text(
                                        "The Steinway Community Concert Hall",
                                        softWrap: true,
                                        fontSize: SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 11.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      CustomWidgets.text(
                                        "Is available for a wide range of activities and events. With its\n combination of functionality and style, the Steinway Community\n Concert Hall",
                                        softWrap: true,
                                        fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 9.sp,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Container(
                                        height: SizerUtil.deviceType == DeviceType.mobile ? 27.h : 33.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              concert,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      CustomWidgets.text(
                                        "Ready To Host A Multitude Of Activities",
                                        softWrap: true,
                                        fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.5.sp : 10.sp,
                                        fontWeight: FontWeight.w800,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      CustomWidgets.text(
                                        " Whether you are planning a concert, hosting a conference,\n organizing a student recital, or conduction masterclass, our venue\n provides the perfect setting to accommodate your needs.",
                                        softWrap: true,
                                        fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 8.5.sp,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),

                                      // concert hall categoryApi
                                      RefreshIndicator(
                                        color: CustomColor.btn,
                                        onRefresh: () async {
                                          welcomeController.getAllConcertCategoryApi();
                                        },
                                        child: Obx(
                                          () => GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: welcomeController.getAllConcertCategoryList.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisExtent: 25.h,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                            ),
                                            itemBuilder: (context, index) {
                                              var concertList = welcomeController.getAllConcertCategoryList[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                    Routes.CONSERT_HALL_RENTALS_DETAIL_SCREEN,
                                                    arguments: concertList,
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: CustomColor.btnAbout,
                                                    border: Border.all(
                                                      color: CustomColor.btnGridConBorder,
                                                    ),
                                                    borderRadius: BorderRadius.circular(
                                                      8.sp,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        const Spacer(),
                                                        concertList.file != ""
                                                            ? Padding(
                                                                padding: EdgeInsets.only(
                                                                  left: 1.h,
                                                                  right: 1.h,
                                                                ),
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  child: SizedBox(
                                                                    height: SizerUtil.deviceType == DeviceType.mobile ? 13.h : 16.h,
                                                                    width: SizerUtil.deviceType == DeviceType.mobile ? 13.h : 20.h,
                                                                    child: CustomWidgets.customImage(image: concertList.file!),
                                                                  ),
                                                                ),
                                                              )
                                                            : CustomWidgets.NoImage(),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        SizedBox(
                                                          width: 25.w,
                                                          height: 1.8.h,
                                                          child: CustomWidgets.text(
                                                            concertList.name.toString(),
                                                            softWrap: true,
                                                            textAlign: TextAlign.center,
                                                            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 9.sp : 7.sp,
                                                            fontWeight: FontWeight.w800,
                                                            maxLine: 1,
                                                          ),
                                                        ),
                                                        Divider(
                                                          height: 2.h,
                                                          endIndent: 8.w,
                                                          indent: 8.w,
                                                          thickness: 1,
                                                        ),
                                                        Container(
                                                          width: 30.w,
                                                          height: 5.5.h,
                                                          margin: EdgeInsets.only(
                                                            left: 2.w,
                                                            right: 2.w,
                                                          ),
                                                          child: CustomWidgets.text(concertList.desc.toString(),
                                                              softWrap: true,
                                                              textAlign: TextAlign.center,
                                                              fontSize: SizerUtil.deviceType == DeviceType.mobile ? 6.sp : 6.5.sp,
                                                              maxLine: 4),
                                                        ),
                                                        const Spacer()
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      SizedBox(
                                        height: 0.h,
                                      ),
                                    ],
                                  )
                                : CustomWidgets.NoInertnet(top: 200);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
