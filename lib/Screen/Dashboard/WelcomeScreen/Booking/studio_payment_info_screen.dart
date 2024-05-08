// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay/pay.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/payment_controller.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class StudioPaymentInfo extends StatefulWidget {
  const StudioPaymentInfo({super.key});

  @override
  State<StudioPaymentInfo> createState() => _StudioPaymentInfoState();
}

class _StudioPaymentInfoState extends State<StudioPaymentInfo> {
  PaymentController paymentController = Get.put(PaymentController());
  String studioID = Get.arguments[0];
  String date = Get.arguments[1];
  String plan = Get.arguments[2];
  List<dynamic>? timeslot = Get.arguments[3];

  @override
  void initState() {
    // welcomeController.getPackageApi();
    welcomeController.studioSelePlan.value = plan;
    super.initState();
  }

  @override
  void dispose() {
    welcomeController.packGroupValue.value = 0;
    super.dispose();
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
                    child: Obx(() {
                      // no internet connection
                      return isInternetAvailable.value == true
                          ? Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  paymentController.paymentInfoData.value.studioName != null
                                      ? Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Table(
                                            border: TableBorder.all(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey.shade300,
                                            ),
                                            children: [
                                              TableRow(children: [
                                                /// STUDIO NAME
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Studio Name",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: CustomWidgets.text(
                                                    paymentController.paymentInfoData.value.studioName.toString(),
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
                                                  child: paymentController.paymentInfoData.value.date.toString() != "" &&
                                                          paymentController.paymentInfoData.value.date.toString() != null
                                                      ? CustomWidgets.text(
                                                          paymentController.paymentInfoData.value.date.toString(),
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

                                              ///plan
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Plan",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: CustomWidgets.text(
                                                    paymentController.paymentInfoData.value.plan!.capitalize.toString(),
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
                                                          "Time",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: paymentController.paymentInfoData.value.timeSlot!.isNotEmpty &&
                                                          paymentController.paymentInfoData.value.timeSlot != null
                                                      ? paymentController.paymentInfoData.value.timeSlot!.length == 1
                                                          ? CustomWidgets.text(
                                                              paymentController.paymentInfoData.value.timeSlot!.first,
                                                              textAlign: TextAlign.start,
                                                              fontSize: 11.sp,
                                                            )
                                                          : CustomWidgets.text(
                                                              "${paymentController.paymentInfoData.value.timeSlot!.first.split(" - ").first} - ${paymentController.paymentInfoData.value.timeSlot!.last.split(" - ").last}",
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

                                              ///total booked hour
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
                                                  child: paymentController.paymentInfoData.value.timeSlot!.isNotEmpty &&
                                                          paymentController.paymentInfoData.value.timeSlot != null
                                                      ? CustomWidgets.text(
                                                          paymentController.paymentInfoData.value.timeSlot!.length.toString(),
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

                                              /// Discount
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Discount",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: paymentController.paymentInfoData.value.discount.toString() != "" &&
                                                          paymentController.paymentInfoData.value.discount.toString() != null
                                                      ? CustomWidgets.text(
                                                          paymentController.paymentInfoData.value.discount.toString(),
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                        )
                                                      : const Text("-"),
                                                )),
                                              ]),

                                              /// amount
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                        child: CustomWidgets.text(
                                                          "Amount",
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w900,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                  child: paymentController.paymentInfoData.value.amount.toString() != "" &&
                                                          paymentController.paymentInfoData.value.amount.toString() != null
                                                      ? CustomWidgets.text(
                                                          paymentController.paymentInfoData.value.amount.toString(),
                                                          textAlign: TextAlign.start,
                                                          fontSize: 11.sp,
                                                        )
                                                      : const Text("-"),
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
                                                  child: paymentController.paymentInfoData.value.totalAmount.toString() != "" &&
                                                          paymentController.paymentInfoData.value.totalAmount.toString() != null
                                                      ? CustomWidgets.text(
                                                          paymentController.paymentInfoData.value.totalAmount.toString(),
                                                          textAlign: TextAlign.start,
                                                          fontWeight: FontWeight.w900,
                                                          fontSize: 11.sp,
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
                                  paymentController.paymentInfoData.value.remainingHour != null
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
                                                    // welcomeController.str.value = "hourly";
                                                    welcomeController.studioSelePlan.value = "hourly";

                                                    paymentController.studioPaymentInfokAPI(
                                                      studioID: studioID,
                                                      date: date,
                                                      plan: "hourly",
                                                      timeslot: timeslot,
                                                      userId: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => ListTile(
                                                title: CustomWidgets.text(
                                                  "Use your prepaid package: ${paymentController.paymentInfoData.value.walletType!.walletName.toString()}",
                                                  softWrap: true,
                                                  fontSize: 12.5.sp,
                                                ),
                                                subtitle: CustomWidgets.text(
                                                  "Remaining Hour : ${paymentController.paymentInfoData.value.remainingHour}",
                                                  softWrap: true,
                                                  fontSize: 12.5.sp,
                                                ),
                                                leading: Radio(
                                                  activeColor: CustomColor.btn,
                                                  value: 1,
                                                  groupValue: welcomeController.packGroupValue.value,
                                                  onChanged: (value) {
                                                    welcomeController.packGroupValue.value = value!;
                                                    welcomeController.studioSelePlan.value = "wallet";

                                                    paymentController.studioPaymentInfokAPI(
                                                      studioID: studioID,
                                                      date: date,
                                                      plan: "wallet",
                                                      timeslot: timeslot,
                                                      userId: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                    );

                                                    if (paymentController.paymentInfoData.value.remainingHour == 0) {
                                                      informationSnackBar(message: "Wallet hours balance is zero");
                                                      // Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                                                    }
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(),
                                  const Spacer(),
                                  Obx(() => CustomButton(
                                        // text: "Pay ${paymentController.paymentInfoData.value.totalAmount.toString()} AED",
                                        text: welcomeController.studioSelePlan.value == "wallet" &&
                                                paymentController.paymentInfoData.value.remainingHour != 0
                                            ? "Book Now"
                                            : paymentController.paymentInfoData.value.totalAmount != null
                                                ? "Pay ${paymentController.paymentInfoData.value.totalAmount.toString()} AED"
                                                : "Pay 0 AED",
                                        width: 90.w,
                                        onPressed: () {
                                          var appleDiscount =
                                              (double.parse(paymentController.paymentInfoData.value.discount!.split("%").first) / 100) *
                                                  paymentController.paymentInfoData.value.amount!;
                                          String checkUserRole = getuserRole();
                                          if (checkUserRole == "superAdmin") {
                                            bookingController.studioBookAPI(
                                                studioID: studioID,
                                                date: date,
                                                plan: welcomeController.studioSelePlan.value,
                                                timeslot: timeslot,
                                                userId: LoginSuccessModel.fromJson(
                                                  GetStorage().read(
                                                    userData,
                                                  ),
                                                ).data!.sId.toString(),
                                                payment: "");
                                          } else {
                                            if (welcomeController.studioSelePlan.value == "wallet" &&
                                                paymentController.paymentInfoData.value.timeSlot!.length <=
                                                    paymentController.paymentInfoData.value.remainingHour! &&
                                                paymentController.paymentInfoData.value.remainingHour! != 0 &&
                                                paymentController.paymentInfoData.value.remainingHour != null) {
                                              bookingController.studioBookAPI(
                                                  studioID: studioID,
                                                  date: date,
                                                  plan: welcomeController.studioSelePlan.value,
                                                  timeslot: timeslot,
                                                  walletId: paymentController.paymentInfoData.value.walletType!.sId,
                                                  userId: LoginSuccessModel.fromJson(
                                                    GetStorage().read(
                                                      userData,
                                                    ),
                                                  ).data!.sId.toString(),
                                                  payment: "");
                                              if (paymentController.paymentInfoData.value.remainingHour! != 0 &&
                                                  paymentController.paymentInfoData.value.remainingHour != null) {
                                                bookingController.studioBookAPI(
                                                    studioID: studioID,
                                                    date: date,
                                                    plan: welcomeController.studioSelePlan.value,
                                                    timeslot: timeslot,
                                                    walletId: paymentController.paymentInfoData.value.walletType!.sId,
                                                    userId: LoginSuccessModel.fromJson(
                                                      GetStorage().read(
                                                        userData,
                                                      ),
                                                    ).data!.sId.toString(),
                                                    payment: "");
                                              }
                                            } else {
                                              if (kDebugMode) {
                                                print('book id ::: ${bookingController.studioBookingDetails.value.bookingId.toString()}');
                                              }
                                              Platform.isIOS
                                                  ? showModalBottomSheet(
                                                      context: context,
                                                      backgroundColor: CustomColor.btnBCon,
                                                      shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.vertical(
                                                          top: Radius.circular(10),
                                                        ),
                                                      ),
                                                      builder: (BuildContext context1) {
                                                        return GestureDetector(
                                                          onTap: () {},
                                                          child: SizedBox(
                                                            height: 200,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets.all(25),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: <Widget>[
                                                                      CustomWidgets.text(
                                                                        "For Book Your Hours",
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: 14.sp,
                                                                      ),
                                                                      const Spacer(),
                                                                      InkWell(
                                                                        child: const Icon(Icons.close),
                                                                        onTap: () {
                                                                          Get.back(closeOverlays: true);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                //paytabs

                                                                GestureDetector(
                                                                  onTap: () {
                                                                    bookingController.studioBookAPI(
                                                                      studioID: studioID,
                                                                      date: date,
                                                                      plan: welcomeController.studioSelePlan.value,
                                                                      walletId: paymentController.paymentInfoData.value.walletType!.sId,
                                                                      timeslot: timeslot,
                                                                      userId: LoginSuccessModel.fromJson(
                                                                        GetStorage().read(
                                                                          userData,
                                                                        ),
                                                                      ).data!.sId.toString(),
                                                                      payment: "",
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                      width: 300,
                                                                      height: 50,
                                                                      decoration: BoxDecoration(
                                                                          color: CustomColor.paytabsBtn, borderRadius: BorderRadius.circular(5)),
                                                                      alignment: Alignment.center,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          CustomWidgets.text(
                                                                            "Pay By card / Apple pay",
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 17.sp,
                                                                          ),
                                                                        ],
                                                                      )),
                                                                ),
                                                                // apple pay
                                                                /*     ApplePayButton(
                                                                  // ignore: deprecated_member_use
                                                                  paymentConfigurationAsset: 'applepay.json',

                                                                  paymentItems: [
                                                                    PaymentItem(
                                                                      label:
                                                                          "${paymentController.paymentInfoData.value.studioName.toString()} Booking",
                                                                      amount: paymentController.paymentInfoData.value.amount
                                                                          .toString(), // Replace with the actual amount
                                                                      status: PaymentItemStatus.final_price,
                                                                    ),
                                                                    PaymentItem(
                                                                        label: "Discount",
                                                                        // Replace with the actual amount
                                                                        // status: PaymentItemStatus.unknown,
                                                                        amount: appleDiscount.toString(),
                                                                        type: PaymentItemType.item),
                                                                    PaymentItem(
                                                                      label: 'House of pianos',
                                                                      amount: paymentController.paymentInfoData.value.totalAmount.toString(),
                                                                      status: PaymentItemStatus.final_price,
                                                                    )
                                                                  ],
                                                                  style: ApplePayButtonStyle.black,
                                                                  type: ApplePayButtonType.plain,
                                                                  width: 300,
                                                                  height: 50,
                                                                  margin: const EdgeInsets.only(top: 15.0),

                                                                  onPressed: () {
                                                                    bookingController.studioBookAPI(
                                                                        studioID: studioID,
                                                                        date: date,
                                                                        plan: welcomeController.studioSelePlan.value,
                                                                        walletId: paymentController.paymentInfoData.value.walletType!.sId,
                                                                        timeslot: timeslot,
                                                                        userId: LoginSuccessModel.fromJson(
                                                                          GetStorage().read(
                                                                            userData,
                                                                          ),
                                                                        ).data!.sId.toString(),
                                                                        payment: "applePay");
                                                                  },
                                                                  onPaymentResult: (Map<String, dynamic> value) {
                                                                    print("Response type: ${value.runtimeType}");
                                                                    print("Response --------------->");
                                                                    print(value);
                                                                    paymentController.responseData = value;
                                                                    print("----------------------------------------------\n");
                                                                    print(
                                                                        '---------------Payment Method Network: ${paymentController.responseData!['paymentMethod']['network']}');

                                                                    print("Booking id ---------------> ${bookingController.studioBookId.value}");

                                                                    paymentController.applePaymentResponse(
                                                                        paymentStatus: "success",
                                                                        transactionId: paymentController.responseData!['transactionIdentifier'],
                                                                        paymentMethod: "applepay",
                                                                        cardType: paymentController.responseData!['paymentMethod']['network'],
                                                                        paymentDescription: paymentController.responseData!['paymentMethod']
                                                                                ['displayName']
                                                                            .toString()
                                                                            .split(" ")
                                                                            .last,
                                                                        amount: paymentController.paymentInfoData.value.totalAmount.toString(),
                                                                        bookingId: bookingController.studioBookingDetails.value.bookingId.toString());
                                                                    Get.back(closeOverlays: true);
                                                                    // Get.toNamed(Routes.APPLE_SUCCESSFULL_SCREEN);
                                                                    // if (paymentController.responseData != null) {
                                                                    //   Get.toNamed(Routes.PAYMENT_SUCCESS_SCREEN);
                                                                    // }
                                                                    // successSnackBar(message: "Payment sucessfully");
                                                                  },
                                                                  onError: (error) {
                                                                    print("error --------------->");
                                                                    print(error);
                                                                    // Get.toNamed(Routes.APPLE_FAILED_SCREEN);
                                                                    print(bookingController.studioBookingDetails.value.bookingId.toString());
                                                                    // print(widget.bookId);
                                                                    print("error --------------->");
                                                                    Get.back(closeOverlays: true);

                                                                    paymentController.applePaymentResponse(
                                                                        paymentStatus: "failed",
                                                                        transactionId: "",
                                                                        paymentMethod: "",
                                                                        cardType: "",
                                                                        paymentDescription: "",
                                                                        amount: paymentController.paymentInfoData.value.totalAmount.toString(),
                                                                        // bookingId: widget.bookingIdScreen!);
                                                                        bookingId: bookingController.studioBookingDetails.value.bookingId.toString());

                                                                    // );
                                                                    // errorSnackBar(message: "Payment failed");
                                                                  },
                                                                  loadingIndicator: const Center(
                                                                    child: CircularProgressIndicator(),
                                                                  ),
                                                                )
                                                            */
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      })
                                                  : bookingController.studioBookAPI(
                                                      studioID: studioID,
                                                      date: date,
                                                      plan: welcomeController.studioSelePlan.value,
                                                      timeslot: timeslot,
                                                      walletId: paymentController.paymentInfoData.value.walletType!.sId,
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
                                ],
                              ),
                            )
                          : CustomWidgets.NoInertnet(top: 200);
                    }),
                  ),
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
