// ignore_for_file: avoid_print, unused_import

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:piano_project/Controller/authetication_controller.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:sizer/sizer.dart';
import '../../../Controller/welcome_controller.dart';
import '../../../Data/Model/login_response_model.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/string_constants.dart';
import '../../../Widget/custom_widget.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  AuthController authController = Get.put(AuthController());
  WelcomeController welcomeController = Get.put(WelcomeController());

  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    // log('token ::: ${authController.currentUserDetails.value.token}');
    // authController.getUser(isLoaderShow: false);
    welcomeController.getBannerApi(isLoaderShow: true);
    bool isEmpty = GetStorage().read(userData) != null;

    if (isEmpty == true) {
      print("if.........$isEmpty");
      authController.checkLoginUser(
          email: LoginSuccessModel.fromJson(
        GetStorage().read(
          userData,
        ),
      ).data!.email.toString());
    }

    // authController.isLogin.value == true
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
              SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Obx(
                    () => isInternetAvailable.value == true
                        ? Column(
                            children: [
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // logout
                                  Obx(
                                    () {
                                      return (authController.isLogin.value == true)
                                          ? GestureDetector(
                                              onTap: () async {
                                                // authController.userDataList.clear();
                                                authController.logoutAPI();
                                                await GoogleSignIn().signOut();

                                                authController.isLogin.value = false;
                                              },
                                              child: Container(
                                                color: Colors.white,
                                                height: 5.h,
                                                width: 5.w,
                                                child: Container(
                                                  color: Colors.white,
                                                  height: 5.h,
                                                  width: 5.w,
                                                  child: (authController.isLogin.value == true)
                                                      ? Image.asset(
                                                          logout,
                                                        )
                                                      : Container(),
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 5.h,
                                              width: 5.h,
                                            );
                                    },
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                  ),
                                  // notification
                                  Obx(
                                    () {
                                      // bool isCheck = getVerifyStatus();

                                      // if (isCheck != true)
                                      return (authController.isLogin.value == true)
                                          ? GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                  Routes.NOTIFICATION_SCREEN,
                                                );
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                  9.5,
                                                ),
                                                height: 5.h,
                                                width: 5.h,
                                                child: Image.asset(
                                                  notification,
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 5.h,
                                              width: 5.h,
                                            );
                                    },
                                  ),
                                ],
                              ),
                              Image.asset(
                                logo,
                                scale: SizerUtil.deviceType == DeviceType.mobile ? 4 : 2,
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              SizedBox(
                                height: SizerUtil.deviceType == DeviceType.mobile ? 3.h : 5.h,
                                width: 80.w,
                                child: Center(
                                  child: CustomWidgets().buildRichText(
                                    fontSize1: SizerUtil.deviceType == DeviceType.mobile ? 16.5.sp : 16.sp,
                                    fontSize: SizerUtil.deviceType == DeviceType.mobile ? 16.5.sp : 16.sp,
                                    color1: CustomColor.black,
                                    fontWeight2: FontWeight.w800,
                                    fontWeight1: FontWeight.normal,
                                    text1: 'Welcome to ',
                                    text2: 'HOUSE OF PIANOS',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.3.h,
                              ),
                              //image banner
                              welcomeController.showDefaultBanner.value == true && welcomeController.bannerDataList.isNotEmpty
                                  ? CarouselSlider(
                                      items: welcomeController.bannerDataList.map((imagePath) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () async {
                                                if (imagePath.navigation == "studioWallet") {
                                                  // authController.isLogin.value == true ? welcomeController.getPackageApi() : null;
                                                  final result = await Get.toNamed(
                                                    Routes.PACKAGE_SCREEN,
                                                  );
                                                  if (result != null) {
                                                    print('Package returned: $result');
                                                    welcomeController.getBannerApi(isLoaderShow: true);
                                                    // authController.getUser(isLoaderShow: false);
                                                    bool isEmpty = GetStorage().read(userData) != null;

                                                    if (isEmpty) {
                                                      print("if.........$isEmpty");
                                                      authController.checkLoginUser(
                                                          email: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.email.toString());
                                                    }
                                                  }
                                                } else if (imagePath.navigation == "pianoService") {
                                                  final result = await Get.toNamed(
                                                    Routes.PIANO_SERVICES_SCREEN,
                                                  );
                                                  if (result != null) {
                                                    print('Package returned: $result');
                                                    welcomeController.getBannerApi(isLoaderShow: false);
                                                  }
                                                } else if (imagePath.navigation == "pianoRental") {
                                                  final result = await Get.toNamed(
                                                    Routes.PIANO_RENTALS_SCREEN,
                                                  );
                                                  if (result != null) {
                                                    print('Package returned: $result');
                                                    welcomeController.getBannerApi(isLoaderShow: false);
                                                  }
                                                } else if (imagePath.navigation == "concertHallRental") {
                                                  final result = await Get.toNamed(
                                                    Routes.CONSERT_HALL_RENTALS_SCREEN,
                                                  );
                                                  if (result != null) {
                                                    print('Package returned: $result');
                                                    welcomeController.getBannerApi(isLoaderShow: false);
                                                  }
                                                } else if (imagePath.navigation == "studioHallRental") {
                                                  final result = await Get.toNamed(
                                                    Routes.STUDIO_RENTALS_SCREEN,
                                                  );
                                                  if (result != null) {
                                                    print('Package returned: $result');
                                                    welcomeController.getBannerApi(isLoaderShow: false);
                                                  }
                                                } else if (imagePath.navigation == "eventAndConcert") {
                                                  final result = await Get.toNamed(
                                                    Routes.EVENT_CONSERT_SCREEN,
                                                  );
                                                  if (result != null) {
                                                    print('Package returned: $result');
                                                    welcomeController.getBannerApi(isLoaderShow: false);
                                                  }
                                                } else {
                                                  print("no");
                                                }
                                              },
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //banner image
                                                  child: CachedNetworkImage(
                                                    imageUrl: '$imageUrl${imagePath.banner}',
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) {
                                                      return Shimmer.fromColors(
                                                        baseColor: Colors.grey[300]!,
                                                        highlightColor: Colors.white,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        aspectRatio: SizerUtil.deviceType == DeviceType.mobile ? 20 / 9 : 15 / 6,
                                        onPageChanged: (index, _) {
                                          welcomeController.currentIndex.value = index;
                                        },
                                      ),
                                      carouselController: _controller,
                                    )
                                  : SizedBox(
                                      height: 25.h,
                                      width: 90.w,
                                    ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // piano rental
                                  GestureDetector(
                                    onTap: () async {
                                      final result = await Get.toNamed(
                                        Routes.PIANO_RENTALS_SCREEN,
                                      );
                                      if (result != null) {
                                        print('PIANO_RENTALS_SCREEN returned: $result');
                                        // authController.getUser(isLoaderShow: false);
                                        bool isEmpty = GetStorage().read(userData) != null;

                                        if (isEmpty) {
                                          print("if.........$isEmpty");
                                          authController.checkLoginUser(
                                              email: LoginSuccessModel.fromJson(
                                            GetStorage().read(
                                              userData,
                                            ),
                                          ).data!.email.toString());
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 13.h,
                                          width: SizerUtil.deviceType == DeviceType.mobile ? 25.w : 23.w,
                                          decoration: BoxDecoration(
                                            color: CustomColor.btnGrid,
                                            border: Border.all(
                                              color: CustomColor.btnBorder,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: Container(
                                            height: 10.h,
                                            width: 10.w,
                                            margin: EdgeInsets.all(
                                              8.sp,
                                            ),
                                            child: Image.asset(
                                              pianoRentals,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        CustomWidgets.text(
                                          "Piano Rentals",
                                          softWrap: false,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.5.sp : 9.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                  //studio rental
                                  GestureDetector(
                                    onTap: () async {
                                      final result = await Get.toNamed(
                                        Routes.STUDIO_RENTALS_SCREEN,
                                      );
                                      if (result != null) {
                                        print('STUDIO_RENTALS_SCREEN returned: $result');
                                        // authController.getUser(
                                        //   isLoaderShow: false,
                                        // );
                                        bool isEmpty = GetStorage().read(userData) != null;

                                        if (isEmpty) {
                                          print("if.........$isEmpty");
                                          authController.checkLoginUser(
                                              email: LoginSuccessModel.fromJson(
                                            GetStorage().read(
                                              userData,
                                            ),
                                          ).data!.email.toString());
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 13.h,
                                          width: SizerUtil.deviceType == DeviceType.mobile ? 25.w : 23.w,
                                          decoration: BoxDecoration(
                                            color: CustomColor.btnGrid,
                                            border: Border.all(
                                              color: CustomColor.btnBorder,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: Container(
                                            height: 10.h,
                                            width: 10.w,
                                            margin: EdgeInsets.only(
                                              left: 4.w,
                                              right: 4.w,
                                              bottom: 2.h,
                                            ),
                                            child: Image.asset(
                                              studioRentals,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        CustomWidgets.text(
                                          "Studio Rentals",
                                          softWrap: false,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.5.sp : 9.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                  //concert hall rental
                                  GestureDetector(
                                    onTap: () async {
                                      final result = await Get.toNamed(
                                        Routes.CONSERT_HALL_RENTALS_SCREEN,
                                      );
                                      if (result != null) {
                                        print(
                                          'CONSERT_HALL_RENTALS_SCREEN returned: $result',
                                        );
                                        // authController.getUser(
                                        //   isLoaderShow: false,
                                        // );
                                        bool isEmpty = GetStorage().read(userData) != null;

                                        if (isEmpty) {
                                          print("if.........$isEmpty");
                                          authController.checkLoginUser(
                                              email: LoginSuccessModel.fromJson(
                                            GetStorage().read(
                                              userData,
                                            ),
                                          ).data!.email.toString());
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 13.h,
                                          width: SizerUtil.deviceType == DeviceType.mobile ? 25.w : 23.w,
                                          decoration: BoxDecoration(
                                            color: CustomColor.btnGrid,
                                            border: Border.all(
                                              color: CustomColor.btnBorder,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: Container(
                                            height: 10.h,
                                            width: 10.w,
                                            margin: EdgeInsets.all(
                                              8.sp,
                                            ),
                                            child: Image.asset(
                                              concertHall,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        CustomWidgets.text(
                                          "Concert Hall Rental",
                                          softWrap: false,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.5.sp : 9.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  //piano services
                                  GestureDetector(
                                    onTap: () async {
                                      final result = await Get.toNamed(
                                        Routes.PIANO_SERVICES_SCREEN,
                                      );
                                      if (result != null) {
                                        print(
                                          'PIANO_SERVICES_SCREEN returned: $result',
                                        );
                                        // authController.getUser(
                                        //   isLoaderShow: false,
                                        // );
                                        bool isEmpty = GetStorage().read(userData) != null;

                                        if (isEmpty) {
                                          print("if.........$isEmpty");
                                          authController.checkLoginUser(
                                              email: LoginSuccessModel.fromJson(
                                            GetStorage().read(
                                              userData,
                                            ),
                                          ).data!.email.toString());
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 13.h,
                                            width: SizerUtil.deviceType == DeviceType.mobile ? 25.w : 23.w,
                                            decoration: BoxDecoration(
                                              color: CustomColor.btnGrid,
                                              border: Border.all(
                                                color: CustomColor.btnBorder,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                            ),
                                            child: Container(
                                              height: 10.h,
                                              width: 10.w,
                                              margin: EdgeInsets.all(
                                                8.sp,
                                              ),
                                              child: Image.asset(
                                                pianoServices,
                                              ),
                                            )),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        CustomWidgets.text(
                                          "Piano Services",
                                          softWrap: false,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.5.sp : 9.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                  //event & concerts
                                  GestureDetector(
                                    onTap: () async {
                                      final result = await Get.toNamed(
                                        Routes.EVENT_CONSERT_SCREEN,
                                      );
                                      if (result != null) {
                                        print(
                                          'EVENT_CONSERT_SCREEN returned: $result',
                                        );
                                        // authController.getUser(
                                        //   isLoaderShow: false,
                                        // );

                                        bool isEmpty = GetStorage().read(userData) != null;

                                        if (isEmpty) {
                                          print("if.........$isEmpty");
                                          authController.checkLoginUser(
                                              email: LoginSuccessModel.fromJson(
                                            GetStorage().read(
                                              userData,
                                            ),
                                          ).data!.email.toString());
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 13.h,
                                            width: SizerUtil.deviceType == DeviceType.mobile ? 25.w : 23.w,
                                            decoration: BoxDecoration(
                                              color: CustomColor.btnGrid,
                                              border: Border.all(
                                                color: CustomColor.btnBorder,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                            ),
                                            child: Container(
                                              height: 10.h,
                                              width: 10.w,
                                              margin: EdgeInsets.all(
                                                8.sp,
                                              ),
                                              child: Image.asset(
                                                event2,
                                              ),
                                            )),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        CustomWidgets.text(
                                          "Events & Concerts",
                                          softWrap: false,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.5.sp : 9.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                  //find piano teacher
                                  GestureDetector(
                                    onTap: () async {
                                      final result = await Get.toNamed(
                                        Routes.PIANO_TEACHER_SCREEN,
                                      );
                                      if (result != null) {
                                        print(
                                          'PIANO_TEACHER_SCREEN returned: $result',
                                        );
                                        // authController.getUser(
                                        //   isLoaderShow: false,
                                        // );

                                        bool isEmpty = GetStorage().read(userData) != null;

                                        if (isEmpty) {
                                          print("if.........$isEmpty");
                                          authController.checkLoginUser(
                                              email: LoginSuccessModel.fromJson(
                                            GetStorage().read(
                                              userData,
                                            ),
                                          ).data!.email.toString());
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 13.h,
                                          width: SizerUtil.deviceType == DeviceType.mobile ? 25.w : 23.w,
                                          decoration: BoxDecoration(
                                            color: CustomColor.btnGrid,
                                            border: Border.all(
                                              color: CustomColor.btnBorder,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: Container(
                                            height: 10.h,
                                            width: 10.w,
                                            margin: EdgeInsets.all(
                                              8.sp,
                                            ),
                                            child: Image.asset(
                                              pianoTeacher,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        CustomWidgets.text(
                                          "Find Piano Teachers",
                                          softWrap: false,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.5.sp : 9.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : CustomWidgets.NoInertnet(top: 250),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
