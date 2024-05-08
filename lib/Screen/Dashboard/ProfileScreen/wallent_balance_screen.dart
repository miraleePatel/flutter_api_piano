// ignore_for_file: unrelated_type_equality_checks, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Controller/profile_controller.dart';
import 'package:piano_project/Utils/app_color.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:sizer/sizer.dart';
import '../../../Widget/custom_widget.dart';

class WallentBalanceScreen extends StatefulWidget {
  const WallentBalanceScreen({super.key});

  @override
  State<WallentBalanceScreen> createState() => _WallentBalanceScreenState();
}

class _WallentBalanceScreenState extends State<WallentBalanceScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.walletBalanceApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                backgroundImage,
              ),
              CustomWidgets.CustAppbar(
                title: "Wallet Balance",
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                  top: 7.5.h,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Obx(
                    () {
                      // No internet connection
                      return isInternetAvailable.value == true
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                Obx(
                                  () {
                                    return (profileController.walletBalanceData.value.status == 1)
                                        ? (profileController.walletBalanceData.value.studioWallet!.length != 0 ||
                                                profileController.walletBalanceData.value.concertWallet!.length != 0)
                                            ? Column(
                                                children: [
                                                  // Studio Package - Remaining hours
                                                  profileController.walletBalanceData.value.studioWallet!.length != 0
                                                      ? CustomWidgets.customContainer(
                                                          margintop: 2.h,
                                                          top: 4.h,
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                CustomWidgets.text(
                                                                  "Studio Rental :",
                                                                  fontSize: 14.sp,
                                                                  fontWeight: FontWeight.w800,
                                                                ),
                                                                ListView.builder(
                                                                    shrinkWrap: true,
                                                                    itemCount: profileController.walletBalanceData.value.studioWallet!.length,
                                                                    physics: const NeverScrollableScrollPhysics(),
                                                                    itemBuilder: (context, index) {
                                                                      var studioWallet =
                                                                          profileController.walletBalanceData.value.studioWallet![index];
                                                                      return Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          SizedBox(
                                                                            height: 2.h,
                                                                          ),
                                                                          CustomWidgets.text(
                                                                            "${studioWallet.walletName}",
                                                                            fontSize: 13.sp,
                                                                            color: CustomColor.btn,
                                                                          ),
                                                                          SizedBox(
                                                                            height: 1.h,
                                                                          ),
                                                                          studioWallet.walletName != ""
                                                                              ? CustomWidgets.text(
                                                                                  '${studioWallet.walletHour! > 1 ? 'Remaining Hours :' : 'Remaining Hour :'}  ${studioWallet.walletHour}',
                                                                                  fontSize: 11.sp,
                                                                                )
                                                                              : CustomWidgets.text(
                                                                                  ' - ',
                                                                                  fontSize: 10.sp,
                                                                                ),
                                                                        ],
                                                                      );
                                                                    }),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),

                                                  // Concert hall - cancelling hour

                                                  profileController.walletBalanceData.value.concertWallet!.length != 0
                                                      ? CustomWidgets.customContainer(
                                                          margintop: 2.h,
                                                          top: 4.h,
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                CustomWidgets.text(
                                                                  "Concert Hall : ",
                                                                  fontSize: 14.sp,
                                                                  fontWeight: FontWeight.w800,
                                                                ),
                                                                ListView.builder(
                                                                  shrinkWrap: true,
                                                                  itemCount: profileController.walletBalanceData.value.concertWallet!.length,
                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                  itemBuilder: (context, index) {
                                                                    var concertWallet =
                                                                        profileController.walletBalanceData.value.concertWallet![index];

                                                                    return Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        SizedBox(
                                                                          height: 2.h,
                                                                        ),
                                                                        CustomWidgets.text(
                                                                          "${concertWallet.concertHall}",
                                                                          fontSize: 13.sp,
                                                                          color: CustomColor.btn,
                                                                        ),
                                                                        SizedBox(
                                                                          height: 1.h,
                                                                        ),
                                                                        concertWallet.concertHall != ""
                                                                            ? CustomWidgets.text(
                                                                                '${concertWallet.walletHour! > 1 ? 'Remaining Hours :' : 'Remaining Hour :'}  ${concertWallet.walletHour}',
                                                                                fontSize: 11.sp,
                                                                              )
                                                                            : CustomWidgets.text(
                                                                                ' - ',
                                                                                fontSize: 10.sp,
                                                                              ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              )
                                            : Center(
                                                child: Padding(
                                                padding: EdgeInsets.only(top: 35.h),
                                                child:
                                                    CustomWidgets.text('There are no hours remaining', fontSize: 14.sp, color: CustomColor.btnSelect),
                                              ))
                                        : Container();
                                  },
                                )
                              ],
                            )
                          : CustomWidgets.NoInertnet(top: 200);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
