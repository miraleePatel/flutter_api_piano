// ignore_for_file: unnecessary_null_comparison, unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Data/Model/login_response_model.dart';
import 'package:piano_project/Utils/constant_widgets.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/booking_controller.dart';
import '../../../../Controller/payment_controller.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class ConcerPaymentInfo extends StatefulWidget {
  const ConcerPaymentInfo({super.key});

  @override
  State<ConcerPaymentInfo> createState() => _ConcerPaymentInfoState();
}

class _ConcerPaymentInfoState extends State<ConcerPaymentInfo> {
  PaymentController paymentController = Get.put(PaymentController());
  BookingController bookingController = Get.put(BookingController());
  String concertId = Get.arguments[0];
  String date = Get.arguments[1];
  List timeslot = Get.arguments[2];
  bool isBooking = Get.arguments[3];
  @override
  void initState() {
    super.initState();
    welcomeController.concertSelePlan.value = "hourly";
    welcomeController.packGroupValue.value = 0;
    if (isBooking == false) {
      welcomeController.schoolnameController.clear();
      welcomeController.teachernameController.clear();
      welcomeController.performersController.clear();
      welcomeController.guestsController.clear();
      if (kDebugMode) {
        print('booking -------> ${isBooking}');
      }
    } else {
      if (kDebugMode) {
        print('booking -------> ${isBooking}');
        print('guestsController -------> ${welcomeController.guestsController.text}');
        print('performersno -------> ${welcomeController.performersController.text}');
        print('schoolname -------> ${welcomeController.schoolnameController.text}');
        print('teachersname -------> ${welcomeController.teachernameController.text}');
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
                  CustomWidgets.CustAppbar(
                    title: "Payment",
                  ),
                  Expanded(
                      // no internet connection
                      child: Obx(() => isInternetAvailable.value == true
                          ? Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  paymentController.conPayInfoData.value.concertHallName != null
                                      ? Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Table(
                                            border: TableBorder.all(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey.shade300,
                                            ),
                                            children: [
                                              TableRow(children: [
                                                /// Concert NAME
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Concert Hall Name",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: CustomWidgets.text(
                                                    paymentController.conPayInfoData.value.concertHallName.toString(),
                                                    textAlign: TextAlign.start,
                                                    fontSize: 11.sp,
                                                  ),
                                                )),
                                              ]),

                                              /// date
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Date",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: paymentController.conPayInfoData.value.date.toString() != "" &&
                                                          paymentController.conPayInfoData.value.date.toString() != null
                                                      ? CustomWidgets.text(
                                                          paymentController.conPayInfoData.value.date.toString(),
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                        )
                                                      : CustomWidgets.text(
                                                          " - ",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                        ),
                                                )),
                                              ]),

                                              ///total booked hour
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Time",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: paymentController.conPayInfoData.value.timeSlot!.isNotEmpty
                                                      ? paymentController.conPayInfoData.value.timeSlot!.length == 1
                                                          ? CustomWidgets.text(
                                                              paymentController.conPayInfoData.value.timeSlot!.first,
                                                              textAlign: TextAlign.start,
                                                              // overflow:
                                                              //     TextOverflow
                                                              //         .ellipsis ,
                                                              fontSize: 11.sp,
                                                            )
                                                          : CustomWidgets.text(
                                                              "${paymentController.conPayInfoData.value.timeSlot!.first.split(" - ").first} - ${paymentController.conPayInfoData.value.timeSlot!.last.split(" - ").last}",
                                                              textAlign: TextAlign.start,
                                                              // overflow:
                                                              //     TextOverflow
                                                              //         .ellipsis ,
                                                              fontSize: 11.sp,
                                                            )
                                                      : CustomWidgets.text(
                                                          "-",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                        ),
                                                )),
                                              ]),

                                              ///book time
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Total hours",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: paymentController.conPayInfoData.value.timeSlot!.isNotEmpty
                                                      ? CustomWidgets.text(
                                                          paymentController.conPayInfoData.value.timeSlot!.length.toString(),
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                        )
                                                      : CustomWidgets.text(
                                                          "-",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                        ),
                                                )),
                                              ]),

                                              ///total amount
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Total Amount",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: paymentController.conPayInfoData.value.totalAmount.toString() != "" &&
                                                          paymentController.conPayInfoData.value.totalAmount.toString() != null
                                                      ? CustomWidgets.text(
                                                          paymentController.conPayInfoData.value.totalAmount.toString(),
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        )
                                                      : const Text("-"),
                                                )),
                                              ]),
                                            ],
                                          ))
                                      : Container(),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  paymentController.conPayInfoData.value.walletBalance != 0
                                      ? Column(
                                          children: [
                                            Obx(
                                              () => ListTile(
                                                title: CustomWidgets.text(
                                                  'Pay per hour',
                                                  softWrap: true,
                                                  fontSize: 12.5.sp,
                                                ),
                                                leading: Radio(
                                                  activeColor: CustomColor.btn,
                                                  value: 0,
                                                  groupValue: welcomeController.packGroupValue.value,
                                                  onChanged: (value) {
                                                    welcomeController.packGroupValue.value = value!;
                                                    welcomeController.concertSelePlan.value = "hourly";

                                                    paymentController.concertPaymentInfokAPI(
                                                      concertID: concertId,
                                                      plan: "hourly",
                                                      userId: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                      date: date,
                                                      timeslot: bookingController.selectTimeList,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => ListTile(
                                                title: CustomWidgets.text(
                                                  "Optimize Your Remaining Time",
                                                  softWrap: true,
                                                  fontSize: 12.5.sp,
                                                ),
                                                subtitle: CustomWidgets.text(
                                                  "Remaining Hour : ${paymentController.conPayInfoData.value.walletBalance.toString()}",
                                                  softWrap: true,
                                                  fontSize: 12.5.sp,
                                                ),
                                                leading: Radio(
                                                  activeColor: CustomColor.btn,
                                                  value: 1,
                                                  groupValue: welcomeController.packGroupValue.value,
                                                  onChanged: (value) {
                                                    welcomeController.packGroupValue.value = value!;

                                                    welcomeController.concertSelePlan.value = "wallet";

                                                    paymentController.concertPaymentInfokAPI(
                                                      concertID: concertId,
                                                      plan: "wallet",
                                                      userId: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                      date: date,
                                                      timeslot: bookingController.selectTimeList,
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  const Spacer(),
                                  Obx(() => CustomButton(
                                        text: welcomeController.concertSelePlan.value == "wallet" &&
                                                paymentController.conPayInfoData.value.walletBalance != 0
                                            ? "Book Now"
                                            : paymentController.conPayInfoData.value.totalAmount != null
                                                ? "Pay ${paymentController.conPayInfoData.value.totalAmount.toString()} AED"
                                                : "Pay 0 AED",
                                        width: 90.w,
                                        onPressed: () {
                                          String checkUserRole = getuserRole();
                                          if (checkUserRole == "superAdmin") {
                                            isBooking != true
                                                ? bookingController.concerthallBookAPI(
                                                    plan: welcomeController.concertSelePlan.value,
                                                    concertId: concertId,
                                                    date: date,
                                                    timeslot: timeslot,
                                                    userId: LoginSuccessModel.fromJson(
                                                      GetStorage().read(
                                                        userData,
                                                      ),
                                                    ).data!.sId.toString(),
                                                    isBooking: isBooking,
                                                    payment: "")
                                                : bookingController.concerthallBookAPI(
                                                    plan: welcomeController.concertSelePlan.value,
                                                    concertId: concertId,
                                                    date: date,
                                                    guestsno: welcomeController.guestsController.text,
                                                    performersno: welcomeController.performersController.text,
                                                    schoolname: welcomeController.schoolnameController.text,
                                                    teachersname: welcomeController.teachernameController.text,
                                                    timeslot: timeslot,
                                                    userId: LoginSuccessModel.fromJson(
                                                      GetStorage().read(
                                                        userData,
                                                      ),
                                                    ).data!.sId.toString(),
                                                    payment: "");
                                          } else {
                                            //wallent
                                            if (welcomeController.concertSelePlan.value == "wallet" &&
                                                paymentController.conPayInfoData.value.walletBalance != 0) {
                                              paymentController.conPayInfoData.value.timeSlot!.length <=
                                                      paymentController.conPayInfoData.value.walletBalance!
                                                  ? bookingController.concerthallBookAPI(
                                                      plan: "wallet",
                                                      concertId: concertId,
                                                      date: date,
                                                      timeslot: timeslot,
                                                      userId: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                      isBooking: isBooking,
                                                      payment: "")
                                                  : Platform.isIOS
                                                      ? applePaymentSheet(
                                                          context,
                                                          titleText: "For Book Your Hours",
                                                          bookAmount: paymentController.conPayInfoData.value.totalAmount.toString(),
                                                          bookingLabel: paymentController.conPayInfoData.value.concertHallName.toString(),
                                                          discountAmount: "0",
                                                          amount: paymentController.conPayInfoData.value.totalAmount.toString(),
                                                          onTapPaytabs: () {
                                                            isBooking != true
                                                                ? bookingController.concerthallBookAPI(
                                                                    plan: "wallet",
                                                                    concertId: concertId,
                                                                    date: date,
                                                                    timeslot: timeslot,
                                                                    userId: LoginSuccessModel.fromJson(
                                                                      GetStorage().read(
                                                                        userData,
                                                                      ),
                                                                    ).data!.sId.toString(),
                                                                    isBooking: isBooking,
                                                                    payment: "")
                                                                : bookingController.concerthallBookAPI(
                                                                    isBooking: true,
                                                                    plan: "wallet",
                                                                    concertId: concertId,
                                                                    date: date,
                                                                    guestsno: welcomeController.guestsController.text,
                                                                    performersno: welcomeController.performersController.text,
                                                                    schoolname: welcomeController.schoolnameController.text,
                                                                    teachersname: welcomeController.teachernameController.text,
                                                                    timeslot: timeslot,
                                                                    userId: LoginSuccessModel.fromJson(
                                                                      GetStorage().read(
                                                                        userData,
                                                                      ),
                                                                    ).data!.sId.toString(),
                                                                    payment: "");
                                                          },

                                                          /// apple button
                                                          onPressedApple: () {
                                                            isBooking != true
                                                                ? bookingController.concerthallBookAPI(
                                                                    plan: "wallet",
                                                                    concertId: concertId,
                                                                    date: date,
                                                                    timeslot: timeslot,
                                                                    userId: LoginSuccessModel.fromJson(
                                                                      GetStorage().read(
                                                                        userData,
                                                                      ),
                                                                    ).data!.sId.toString(),
                                                                    payment: "applePay")
                                                                : bookingController.concerthallBookAPI(
                                                                    isBooking: true,
                                                                    plan: "wallet",
                                                                    concertId: concertId,
                                                                    date: date,
                                                                    guestsno: welcomeController.guestsController.text,
                                                                    performersno: welcomeController.performersController.text,
                                                                    schoolname: welcomeController.schoolnameController.text,
                                                                    teachersname: welcomeController.teachernameController.text,
                                                                    timeslot: timeslot,
                                                                    userId: LoginSuccessModel.fromJson(
                                                                      GetStorage().read(
                                                                        userData,
                                                                      ),
                                                                    ).data!.sId.toString(),
                                                                    payment: "applePay");
                                                          },
                                                          bookingIdScreen: "concerthall",
                                                          // bookId: bookingController
                                                          //     .concertBookingDetails
                                                          //     .value
                                                          //     .bookingId
                                                          //     .toString()
                                                        )
                                                      :

                                                      /// Android
                                                      isBooking != true
                                                          ? bookingController.concerthallBookAPI(
                                                              plan: "wallet",
                                                              concertId: concertId,
                                                              date: date,
                                                              timeslot: timeslot,
                                                              userId: LoginSuccessModel.fromJson(
                                                                GetStorage().read(
                                                                  userData,
                                                                ),
                                                              ).data!.sId.toString(),
                                                              isBooking: isBooking,
                                                              payment: "")
                                                          : bookingController.concerthallBookAPI(
                                                              isBooking: true,
                                                              plan: "wallet",
                                                              concertId: concertId,
                                                              date: date,
                                                              guestsno: welcomeController.guestsController.text,
                                                              performersno: welcomeController.performersController.text,
                                                              schoolname: welcomeController.schoolnameController.text,
                                                              teachersname: welcomeController.teachernameController.text,
                                                              timeslot: timeslot,
                                                              userId: LoginSuccessModel.fromJson(
                                                                GetStorage().read(
                                                                  userData,
                                                                ),
                                                              ).data!.sId.toString(),
                                                              payment: "");
                                            }
                                            //hourly
                                            else {
                                              Platform.isIOS
                                                  ? applePaymentSheet(
                                                      context,
                                                      titleText: "For Book Your Hours",
                                                      bookAmount: paymentController.conPayInfoData.value.totalAmount.toString(),
                                                      bookingLabel: paymentController.conPayInfoData.value.concertHallName.toString(),
                                                      discountAmount: "0",
                                                      amount: paymentController.conPayInfoData.value.totalAmount.toString(),
                                                      onTapPaytabs: () {
                                                        isBooking != true
                                                            ? bookingController.concerthallBookAPI(
                                                                plan: "hourly",
                                                                concertId: concertId,
                                                                date: date,
                                                                timeslot: timeslot,
                                                                userId: LoginSuccessModel.fromJson(
                                                                  GetStorage().read(
                                                                    userData,
                                                                  ),
                                                                ).data!.sId.toString(),
                                                                isBooking: isBooking,
                                                                payment: "")
                                                            : bookingController.concerthallBookAPI(
                                                                isBooking: true,
                                                                plan: "hourly",
                                                                concertId: concertId,
                                                                date: date,
                                                                guestsno: welcomeController.guestsController.text,
                                                                performersno: welcomeController.performersController.text,
                                                                schoolname: welcomeController.schoolnameController.text,
                                                                teachersname: welcomeController.teachernameController.text,
                                                                timeslot: timeslot,
                                                                userId: LoginSuccessModel.fromJson(
                                                                  GetStorage().read(
                                                                    userData,
                                                                  ),
                                                                ).data!.sId.toString(),
                                                                payment: "");
                                                      },

                                                      /// apple button
                                                      onPressedApple: () {
                                                        isBooking != true
                                                            ? bookingController.concerthallBookAPI(
                                                                plan: "hourly",
                                                                concertId: concertId,
                                                                date: date,
                                                                timeslot: timeslot,
                                                                userId: LoginSuccessModel.fromJson(
                                                                  GetStorage().read(
                                                                    userData,
                                                                  ),
                                                                ).data!.sId.toString(),
                                                                payment: "applePay")
                                                            : bookingController.concerthallBookAPI(
                                                                isBooking: true,
                                                                plan: "hourly",
                                                                concertId: concertId,
                                                                date: date,
                                                                guestsno: welcomeController.guestsController.text,
                                                                performersno: welcomeController.performersController.text,
                                                                schoolname: welcomeController.schoolnameController.text,
                                                                teachersname: welcomeController.teachernameController.text,
                                                                timeslot: timeslot,
                                                                userId: LoginSuccessModel.fromJson(
                                                                  GetStorage().read(
                                                                    userData,
                                                                  ),
                                                                ).data!.sId.toString(),
                                                                payment: "applePay");
                                                      },
                                                      bookingIdScreen: "concerthall",
                                                      // bookId: bookingController
                                                      //     .concertBookingDetails
                                                      //     .value
                                                      //     .bookingId
                                                      //     .toString()
                                                    )
                                                  :

                                                  /// Android
                                                  isBooking != true
                                                      ? bookingController.concerthallBookAPI(
                                                          plan: "hourly",
                                                          concertId: concertId,
                                                          date: date,
                                                          timeslot: timeslot,
                                                          userId: LoginSuccessModel.fromJson(
                                                            GetStorage().read(
                                                              userData,
                                                            ),
                                                          ).data!.sId.toString(),
                                                          isBooking: isBooking,
                                                          payment: "")
                                                      : bookingController.concerthallBookAPI(
                                                          isBooking: true,
                                                          plan: "hourly",
                                                          concertId: concertId,
                                                          date: date,
                                                          guestsno: welcomeController.guestsController.text,
                                                          performersno: welcomeController.performersController.text,
                                                          schoolname: welcomeController.schoolnameController.text,
                                                          teachersname: welcomeController.teachernameController.text,
                                                          timeslot: timeslot,
                                                          userId: LoginSuccessModel.fromJson(
                                                            GetStorage().read(
                                                              userData,
                                                            ),
                                                          ).data!.sId.toString(),
                                                          payment: "");
                                            }
                                          }
                                        },
                                      ))

                                  /*  CustomButton(
                                    text:
                                        "Pay ${paymentController.conPayInfoData.value.totalAmount.toString()} AED",
                                    width: 90.w,
                                    onPressed: () {
                                      String checkUserRole = getuserRole();
                                      if (checkUserRole ==  "superAdmin") {
                                        isBooking ==  true
                                            ? bookingController
                                                .concerthallBookAPI(
                                                    concertId: concertId,
                                                    date: date,
                                                    timeslot: timeslot,
                                                    userId: LoginSuccessModel
                                                        .fromJson(
                                                      GetStorage().read(
                                                        userData,
                                                      ),
                                                    ).data!.sId.toString(),
                                                    isBooking: isBooking,
                                                    payment: "")
                                            : bookingController
                                                .concerthallBookAPI(
                                                    concertId: concertId,
                                                    date: date,
                                                    guestsno: welcomeController
                                                        .guestsController.text,
                                                    performersno:
                                                        welcomeController
                                                            .performersController
                                                            .text,
                                                    schoolname: welcomeController
                                                        .schoolnameController
                                                        .text,
                                                    teachersname:
                                                        welcomeController
                                                            .teachernameController
                                                            .text,
                                                    timeslot: timeslot,
                                                    userId: LoginSuccessModel
                                                        .fromJson(
                                                      GetStorage().read(
                                                        userData,
                                                      ),
                                                    ).data!.sId.toString(),
                                                    payment: "");
                                      } else {
                                        Platform.isIOS
                                            ? applePaymentSheet(context,
                                                amount: paymentController
                                                    .conPayInfoData
                                                    .value
                                                    .totalAmount
                                                    .toString(),
                                                onTapPaytabs: () {
                                                isBooking ==  true
                                                    ? bookingController
                                                        .concerthallBookAPI(
                                                            concertId:
                                                                concertId,
                                                            date: date,
                                                            timeslot: timeslot,
                                                            userId: LoginSuccessModel
                                                                    .fromJson(
                                                              GetStorage().read(
                                                                userData,
                                                              ),
                                                            )
                                                                .data!
                                                                .sId
                                                                .toString(),
                                                            isBooking:
                                                                isBooking,
                                                            payment: "")
                                                    : bookingController
                                                        .concerthallBookAPI(
                                                            concertId:
                                                                concertId,
                                                            date: date,
                                                            guestsno:
                                                                welcomeController
                                                                    .guestsController
                                                                    .text,
                                                            performersno:
                                                                welcomeController
                                                                    .performersController
                                                                    .text,
                                                            schoolname:
                                                                welcomeController
                                                                    .schoolnameController
                                                                    .text,
                                                            teachersname:
                                                                welcomeController
                                                                    .teachernameController
                                                                    .text,
                                                            timeslot: timeslot,
                                                            userId:
                                                                LoginSuccessModel
                                                                        .fromJson(
                                                              GetStorage().read(
                                                                userData,
                                                              ),
                                                            )
                                                                    .data!
                                                                    .sId
                                                                    .toString(),
                                                            payment: "");
                                              },

                                                /// apple button
                                                onPressedApple: () {
                                                bookingController
                                                    .concerthallBookAPI(
                                                        concertId: concertId,
                                                        date: date,
                                                        guestsno:
                                                            welcomeController
                                                                .guestsController
                                                                .text,
                                                        performersno:
                                                            welcomeController
                                                                .performersController
                                                                .text,
                                                        schoolname: welcomeController
                                                            .schoolnameController
                                                            .text,
                                                        teachersname:
                                                            welcomeController
                                                                .teachernameController
                                                                .text,
                                                        timeslot: timeslot,
                                                        userId:
                                                            LoginSuccessModel
                                                                .fromJson(
                                                          GetStorage().read(
                                                            userData,
                                                          ),
                                                        ).data!.sId.toString(),
                                                        payment: "applePay");
                                              },
                                                bookingIdScreen: "concerthall",
                                                bookId: bookingController
                                                    .concertBookingDetails
                                                    .value
                                                    .bookingId
                                                    .toString())
                                            :

                                            /// Android
                                            isBooking ==  true
                                                ? bookingController
                                                    .concerthallBookAPI(
                                                        concertId: concertId,
                                                        date: date,
                                                        timeslot: timeslot,
                                                        userId: LoginSuccessModel
                                                            .fromJson(
                                                          GetStorage().read(
                                                            userData,
                                                          ),
                                                        ).data!.sId.toString(),
                                                        isBooking: isBooking,
                                                        payment: "")
                                                : bookingController
                                                    .concerthallBookAPI(
                                                        concertId: concertId,
                                                        date: date,
                                                        guestsno: welcomeController
                                                            .guestsController
                                                            .text,
                                                        performersno: welcomeController
                                                            .performersController
                                                            .text,
                                                        schoolname: welcomeController
                                                            .schoolnameController
                                                            .text,
                                                        teachersname: welcomeController.teachernameController.text,
                                                        timeslot: timeslot,
                                                        userId: LoginSuccessModel.fromJson(
                                                          GetStorage().read(
                                                            userData,
                                                          ),
                                                        ).data!.sId.toString(),
                                                        payment: "");
                                      }
                                    },
                                  )
                                 */
                                ],
                              ))
                          : CustomWidgets.NoInertnet(top: 200))),
                  SizedBox(
                    height: 3.h,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
