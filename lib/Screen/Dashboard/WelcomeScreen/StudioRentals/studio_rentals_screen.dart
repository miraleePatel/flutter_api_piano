// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/authetication_controller.dart';
import '../../../../Controller/welcome_controller.dart';
import '../../../../Data/Model/get_banner_model.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class StudioRentalsScreen extends StatefulWidget {
  const StudioRentalsScreen({Key? key}) : super(key: key);

  @override
  State<StudioRentalsScreen> createState() => _StudioRentalsScreenState();
}

class _StudioRentalsScreenState extends State<StudioRentalsScreen> {
  WelcomeController welcomeController = Get.put(WelcomeController());
  AuthController authController = Get.put(AuthController());
  String targetName = "studioWallet";
  List<BannerData> bannerGet = [];
  @override
  void initState() {
    welcomeController.studioRentalDataApi();
    getBanner();
    super.initState();
  }

  GetBannerModel? studioWalletBanner;
  String targetNavigation = "studioWallet";
  String bannerImage = "";

  getBanner() {
    for (var banner in welcomeController.bannerDataList) {
      if (banner.navigation == targetNavigation) {
        bannerImage = banner.banner.toString();
        break;
      }
    }
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
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: CustomColor.btn,
                            size: SizerUtil.deviceType == DeviceType.mobile ? 20 : 30,
                          ),
                        ),
                        CustomWidgets.text(
                          "Studios & Practice Rooms",
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
                                Get.toNamed(Routes.STUDIO_RENTAL_BOOK_SCREEN);
                              }
                            },
                            child: SizedBox(
                              width: SizerUtil.deviceType == DeviceType.mobile ? 9.w : 10.w,
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
                        top: 1.h,
                      ),
                      child: RefreshIndicator(
                        color: CustomColor.btn,
                        onRefresh: () async {
                          welcomeController.studioRentalDataApi();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Obx(
                            () {
                              return isInternetAvailable.value == true
                                  ? Column(
                                      children: [
                                        // Container(
                                        //   height: 12.5.h,
                                        //   decoration: BoxDecoration(
                                        //       /* image: DecorationImage(
                                        //       image: AssetImage(
                                        //         studio,
                                        //       ),
                                        //       fit: BoxFit.fill,
                                        //     ), */
                                        //       image: DecorationImage(image: CustomWidgets.customImage(image: bannerImage))),
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.PACKAGE_SCREEN,
                                            );
                                            // authController.isLogin.value == true ? welcomeController.getPackageApi() : null;
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: SizedBox(
                                              // height: 35.h,
                                              width: SizerUtil.deviceType == DeviceType.mobile ? 80.h : 60.h,
                                              child: (bannerImage != null) ? CustomWidgets.customImage(image: bannerImage) : CustomWidgets.NoImage(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        CustomWidgets.text(
                                          "STUDIOS ARE AVAILABLE FOR THOSE WHO \n WANT TO TEACH VOICE OR INSTRUMENTAL LESSONS:",
                                          softWrap: true,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 10.sp,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        Divider(
                                          height: 5.h,
                                          endIndent: 40.w,
                                          indent: 40.w,
                                          thickness: 1,
                                        ),
                                        CustomWidgets.text(
                                          "SUCH AS GUITAR, VIOLIN, FLUTE, OR  OTHER, \n QUIETER INSTRUMENTS",
                                          softWrap: true,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.5.sp : 9.sp,
                                          fontWeight: FontWeight.w800,
                                          color: CustomColor.textStudioRentals,
                                          textAlign: TextAlign.center,
                                        ),
                                        Divider(
                                          height: 5.h,
                                          endIndent: 40.w,
                                          indent: 40.w,
                                          thickness: 1,
                                        ),
                                        CustomWidgets.text(
                                          "OUR STUDIOS",
                                          softWrap: true,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.5.sp : 10.sp,
                                          fontWeight: FontWeight.w800,
                                          color: CustomColor.textStudioRentals,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        //First studio rental

                                        welcomeController.studioRentalList.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                    Routes.STUDIO_RENTALS_DETAIL_SCREEN,
                                                    arguments: welcomeController.studioRentalList.first,
                                                  );
                                                },
                                                child: Container(
                                                  height: SizerUtil.deviceType == DeviceType.mobile ? 22.h : 27.h,
                                                  decoration: BoxDecoration(
                                                    color: CustomColor.btnAbout,
                                                    border: Border.all(
                                                      color: CustomColor.btnGridConBorder,
                                                    ),
                                                    borderRadius: BorderRadius.circular(
                                                      10.sp,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 0.7.h,
                                                      left: 0.7.h,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 0.7.h),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(5),
                                                            child: SizedBox(
                                                              height: SizerUtil.deviceType == DeviceType.mobile ? 15.h : 20.h,
                                                              width: 80.h,
                                                              child: (welcomeController.studioRentalList.first.file != null)
                                                                  ? CustomWidgets.customImage(image: welcomeController.studioRentalList.first.file!)
                                                                  : CustomWidgets.NoImage(),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        CustomWidgets.text(
                                                          welcomeController.studioRentalList.first.name.toString(),
                                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 9.sp,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontWeight: FontWeight.w800,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        //studio rental
                                        Center(
                                          child: welcomeController.studioRentalList.isNotEmpty
                                              ? GridView.builder(
                                                  physics: const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: welcomeController.studioRentalList.length - 1,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisExtent: 19.h,
                                                    mainAxisSpacing: 1.5.h,
                                                    crossAxisSpacing: 2.5.w,
                                                  ),
                                                  itemBuilder: (context, index) {
                                                    if (kDebugMode) {
                                                      print(
                                                          "welcomeController.studioRentalList.length ::::: ${welcomeController.studioRentalList.length}");
                                                    }
                                                    int newIndex = index + 1;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          Routes.STUDIO_RENTALS_DETAIL_SCREEN,
                                                          arguments: welcomeController.studioRentalList[newIndex],
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
                                                              welcomeController.studioRentalList[newIndex].file != ""
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: 1.h,
                                                                          right: 1.h,
                                                                          top: SizerUtil.deviceType == DeviceType.mobile ? 0 : 5,
                                                                          bottom: SizerUtil.deviceType == DeviceType.mobile ? 0 : 5),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        child: SizedBox(
                                                                          height: SizerUtil.deviceType == DeviceType.mobile ? 13.5.h : 14.h,
                                                                          width: SizerUtil.deviceType == DeviceType.mobile ? 13.h : 20.h,
                                                                          child: CustomWidgets.customImage(
                                                                              image: welcomeController.studioRentalList[newIndex].file!),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : CustomWidgets.NoImage(),
                                                              SizedBox(
                                                                width: 25.w,
                                                                child: CustomWidgets.text(
                                                                  welcomeController.studioRentalList[newIndex].name!,
                                                                  softWrap: true,
                                                                  fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 7.sp,
                                                                  textAlign: TextAlign.center,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.w800,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                      ],
                                    )
                                  : CustomWidgets.NoInertnet(top: 200);
                            },
                          ),
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
