// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../Controller/authetication_controller.dart';
import '../../../Controller/booking_controller.dart';
import '../../../Controller/welcome_controller.dart';
import '../../../Data/Model/login_response_model.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/constant_widgets.dart';
import '../../../Utils/string_constants.dart';
import '../../../Widget/custom_widget.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  WelcomeController welcomeController = Get.put(WelcomeController());
  BookingController bookingController = Get.put(BookingController());
  AuthController authController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    authController.isLogin.value == true ? welcomeController.getPackageApi() : null;
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
                    title: "Studios & Practice Rooms",
                  ),
                  // getVerifyStatus() == true
                  authController.isLogin.value == true
                      ? Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 4.w,
                              right: 4.w,
                              top: 1.h,
                            ),
                            child: RefreshIndicator(
                              color: CustomColor.btn,
                              onRefresh: () async {
                                // welcomeController.studioRentalDataApi();
                              },
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Obx(
                                  () {
                                    return isInternetAvailable.value == true
                                        ? Column(
                                            children: [
                                              Container(
                                                height: 20.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      packageBanner,
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              CustomWidgets.text(
                                                "Special packages\nlow price - More hours".toUpperCase(),
                                                softWrap: true,
                                                fontSize: 13.sp,
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
                                                "Select one of the 3 discount packages \n below and save up to 50% on your \n Studio Bookings"
                                                    .toUpperCase(),
                                                softWrap: true,
                                                fontSize: 12.5.sp,
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
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              SizedBox(
                                                height: 80.h,
                                                child: welcomeController.packageDataList.isNotEmpty
                                                    ? ListView.separated(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: welcomeController.packageDataList.length,
                                                        itemBuilder: (context, index) {
                                                          return Column(
                                                            children: [
                                                              CustomWidgets.text(
                                                                welcomeController.packageDataList[index].walletName.toString(),
                                                                softWrap: true,
                                                                fontSize: 12.5.sp,
                                                                fontWeight: FontWeight.w800,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                              SizedBox(
                                                                height: 0.5.h,
                                                              ),
                                                              CustomWidgets.text(
                                                                "*Normal Booking Rate ${welcomeController.packageDataList[index].priceHourly} AED per hr",
                                                                softWrap: true,
                                                                fontSize: 10.5.sp,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                              SizedBox(
                                                                height: 2.h,
                                                              ),
                                                              SizedBox(
                                                                height: 28.h,
                                                                child: ListView.builder(
                                                                  itemCount: welcomeController.packageDataList[index].packageDetail!.length,
                                                                  shrinkWrap: true,
                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                  scrollDirection: Axis.horizontal,
                                                                  itemBuilder: (context, packIndex) {
                                                                    var pakageData =
                                                                        welcomeController.packageDataList[index].packageDetail![packIndex];
                                                                    return GestureDetector(
                                                                      onTap: () {
                                                                        bool isCheck = getVerifyStatus();
                                                                        String checkUserRole = getuserRole();
                                                                        print("index............$index");
                                                                        print('isCheck ::: $isCheck');
                                                                        print('isCheck ::: $checkUserRole');
                                                                        if (getAuthToken() == "") {
                                                                          Get.toNamed(Routes.LOGIN_SCREEN, arguments: "packageScreen");
                                                                        } else {
                                                                          // enqury alert
                                                                          if (authController.loginDetails.value.data!.phoneNo == null ||
                                                                              authController.loginDetails.value.data!.phoneNo == "null" ||
                                                                              authController.loginDetails.value.data!.phoneNo == "" ||
                                                                              authController.loginDetails.value.data!.countryCode == null ||
                                                                              authController.loginDetails.value.data!.file == null) {
                                                                            clearMobileDialog();
                                                                            addMobileDialog(context, onTapMethod: () async {
                                                                              editProfileController.editUserDetails(
                                                                                LoginSuccessModel.fromJson(
                                                                                  GetStorage().read(
                                                                                    userData,
                                                                                  ),
                                                                                ).data!.sId.toString(),
                                                                                fullName: authController.loginDetails.value.data!.fullName.toString(),
                                                                                file: "${flagM.value}.png",
                                                                                countryCode: contryCodeM.value,
                                                                                phoneNo: mobileController.text,
                                                                                address: authController.loginDetails.value.data!.address.toString(),
                                                                              );
                                                                            });
                                                                          } else {
                                                                            if (checkUserRole == "superAdmin") {
                                                                              bookingController.studioWalletRechargeApi(
                                                                                  userId: LoginSuccessModel.fromJson(
                                                                                    GetStorage().read(
                                                                                      userData,
                                                                                    ),
                                                                                  ).data!.sId.toString(),
                                                                                  walletId: welcomeController.packageDataList[index].sId.toString(),
                                                                                  hour: pakageData.packageHour.toString(),
                                                                                  price: pakageData.packageRate!,
                                                                                  payment: "");
                                                                            } else {
                                                                              Platform.isIOS
                                                                                  ? welcomeController.packageDataList[index].remainingWalletHour! +
                                                                                                  pakageData.packageHour! <=
                                                                                              60 &&
                                                                                          welcomeController
                                                                                                  .packageDataList[index].remainingWalletHour !=
                                                                                              null &&
                                                                                          pakageData.packageHour != null
                                                                                      ? applePaymentSheet(
                                                                                          context,
                                                                                          titleText: "To add hours to your wallet",
                                                                                          bookAmount: welcomeController
                                                                                                      .packageDataList[index].walletName
                                                                                                      .toString() ==
                                                                                                  "STUDIOS \"U\" With Upright Pianos"
                                                                                              ? (pakageData.packageHour! * 100).toString()
                                                                                              : (pakageData.packageHour! * 150).toString(),
                                                                                          bookingLabel:
                                                                                              "${pakageData.packageHour.toString()} HOURS PACKAGE",
                                                                                          discountAmount: welcomeController
                                                                                                      .packageDataList[index].walletName
                                                                                                      .toString() ==
                                                                                                  "STUDIOS \"U\" With Upright Pianos"
                                                                                              ? (pakageData.packageHour! * 100 -
                                                                                                      pakageData.packageRate!)
                                                                                                  .toString()
                                                                                              : (pakageData.packageHour! * 150 -
                                                                                                      pakageData.packageRate!)
                                                                                                  .toString(),
                                                                                          amount: pakageData.packageRate.toString(),
                                                                                          onTapPaytabs: () {
                                                                                            bookingController.studioWalletRechargeApi(
                                                                                                userId: LoginSuccessModel.fromJson(
                                                                                                  GetStorage().read(
                                                                                                    userData,
                                                                                                  ),
                                                                                                ).data!.sId.toString(),
                                                                                                walletId: welcomeController.packageDataList[index].sId
                                                                                                    .toString(),
                                                                                                hour: pakageData.packageHour.toString(),
                                                                                                price: pakageData.packageRate!,
                                                                                                payment: "");
                                                                                          },

                                                                                          /// apple button
                                                                                          onPressedApple: () {
                                                                                            bookingController.studioWalletRechargeApi(
                                                                                                userId: LoginSuccessModel.fromJson(
                                                                                                  GetStorage().read(
                                                                                                    userData,
                                                                                                  ),
                                                                                                ).data!.sId.toString(),
                                                                                                walletId: welcomeController.packageDataList[index].sId
                                                                                                    .toString(),
                                                                                                hour: pakageData.packageHour.toString(),
                                                                                                price: pakageData.packageRate!,
                                                                                                payment: "applePay");
                                                                                          },
                                                                                          bookingIdScreen: "package",
                                                                                          // bookId: bookingController
                                                                                          //       .studioWalletRechargeModel.value.bookingId
                                                                                          //       .toString()
                                                                                        )
                                                                                      : bookingController.studioWalletRechargeApi(
                                                                                          userId: LoginSuccessModel.fromJson(
                                                                                            GetStorage().read(
                                                                                              userData,
                                                                                            ),
                                                                                          ).data!.sId.toString(),
                                                                                          walletId:
                                                                                              welcomeController.packageDataList[index].sId.toString(),
                                                                                          hour: pakageData.packageHour.toString(),
                                                                                          price: pakageData.packageRate!,
                                                                                          payment: "")
                                                                                  : bookingController.studioWalletRechargeApi(
                                                                                      userId: LoginSuccessModel.fromJson(
                                                                                        GetStorage().read(
                                                                                          userData,
                                                                                        ),
                                                                                      ).data!.sId.toString(),
                                                                                      walletId:
                                                                                          welcomeController.packageDataList[index].sId.toString(),
                                                                                      hour: pakageData.packageHour.toString(),
                                                                                      price: pakageData.packageRate!,
                                                                                      payment: "");
                                                                            }
                                                                          }
                                                                        }

                                                                        /// Android
                                                                      },
                                                                      child: Card(
                                                                          elevation: 6,
                                                                          shape: const RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                                                            //set border radius more than 50% of height and width to make circle
                                                                          ),
                                                                          child: SingleChildScrollView(
                                                                            physics: const NeverScrollableScrollPhysics(),
                                                                            child: Column(
                                                                              children: [
                                                                                Container(
                                                                                  decoration: const BoxDecoration(
                                                                                      // color: AppColors.titlebgColor,
                                                                                      gradient: LinearGradient(colors: [
                                                                                        CustomColor.blue,
                                                                                        CustomColor.purple,
                                                                                      ]),
                                                                                      borderRadius: BorderRadius.only(
                                                                                          topRight: Radius.circular(10),
                                                                                          topLeft: Radius.circular(10))),
                                                                                  height: 4.h,
                                                                                  width: 28.w,
                                                                                  alignment: Alignment.center,
                                                                                  child: CustomWidgets.text(
                                                                                    pakageData.packageLabel.toString(),
                                                                                    softWrap: true,
                                                                                    fontSize: 10.sp,
                                                                                    color: CustomColor.white,
                                                                                    fontWeight: FontWeight.w800,
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 1.h,
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    CustomWidgets.text(
                                                                                      pakageData.packageHour.toString(),
                                                                                      softWrap: true,
                                                                                      fontSize: 20.sp,
                                                                                      fontWeight: FontWeight.w800,
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 1.w,
                                                                                    ),
                                                                                    CustomWidgets().buildRichText(
                                                                                        text1: "HOURS\n",
                                                                                        text2: "PACKAGE",
                                                                                        color1: CustomColor.black,
                                                                                        fontSize1: 8.sp,
                                                                                        fontSize: 6.5.sp)
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 1.h,
                                                                                ),
                                                                                Container(
                                                                                  color: Colors.red,
                                                                                  height: 4.h,
                                                                                  width: 28.w,
                                                                                  alignment: Alignment.center,
                                                                                  child: CustomWidgets.text(
                                                                                    "SAVE ${pakageData.discount}%",
                                                                                    softWrap: true,
                                                                                    fontSize: 12.5.sp,
                                                                                    color: CustomColor.white,
                                                                                    fontWeight: FontWeight.w800,
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 2.h,
                                                                                ),
                                                                                Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        CustomWidgets.text(
                                                                                          pakageData.packageRate.toString(),
                                                                                          softWrap: true,
                                                                                          fontSize: 20.sp,
                                                                                          fontWeight: FontWeight.w800,
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                        CustomWidgets().buildRichText(
                                                                                            text1: "AED\n",
                                                                                            text2: "",
                                                                                            color1: CustomColor.black,
                                                                                            fontSize1: 8.sp,
                                                                                            fontSize: 6.5.sp)
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 2.h,
                                                                                    ),
                                                                                    Container(
                                                                                      height: 3.h,
                                                                                      width: 23.w,
                                                                                      alignment: Alignment.center,
                                                                                      color: CustomColor.black,
                                                                                      child: CustomWidgets.text("BUY NOW", color: CustomColor.white),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              welcomeController.packageDataList.length - 1 == index
                                                                  ? SizedBox(
                                                                      height: 1.h,
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          );
                                                        },
                                                        separatorBuilder: (context, index) {
                                                          return SizedBox(
                                                            height: 3.h,
                                                          );
                                                        },
                                                      )
                                                    : Container(),
                                              ),
                                              CustomWidgets.text('Terms & Conditions Apply'),
                                              SizedBox(
                                                height: 3.h,
                                              )
                                            ],
                                          )
                                        : CustomWidgets.NoInertnet(top: 200);
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 35.h),
                          child: CustomWidgets.text(
                            "You have to login to see the packages.",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: CustomColor.btnSelect,
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
