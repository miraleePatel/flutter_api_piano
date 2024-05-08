// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import '../../../../Controller/booking_controller.dart';
import '../../../../Controller/payment_controller.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class EventConcertPaymentInfo extends StatefulWidget {
  const EventConcertPaymentInfo({super.key});

  @override
  State<EventConcertPaymentInfo> createState() => _EventConcertPaymentInfoState();
}

class _EventConcertPaymentInfoState extends State<EventConcertPaymentInfo> {
  PaymentController paymentController = Get.put(PaymentController());
  BookingController bookingController = Get.put(BookingController());
  String eventId = Get.arguments;

  @override
  void initState() {
    super.initState();
    paymentController.eventPaymentInfokAPI(
        userId: LoginSuccessModel.fromJson(
          GetStorage().read(
            userData,
          ),
        ).data!.sId.toString(),
        eventId: eventId,
        quantity: welcomeController.ticketCount.value);
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
              Obx(
                () => Column(
                  children: [
                    CustomWidgets.CustAppbar(
                      title: paymentController.eventPayInfoData.value.ticketType == "free" ? "Booking" : "Payment",
                    ),
                    // no internet connection
                    isInternetAvailable.value == true
                        ? Expanded(
                            child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                paymentController.eventPayInfoData.value.name != null
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
                                                        "Name",
                                                        textAlign: TextAlign.start,
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w900,
                                                      ))),
                                              TableCell(
                                                  child: Padding(
                                                padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                child: CustomWidgets.text(
                                                  paymentController.eventPayInfoData.value.name.toString(),
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
                                                        "Venue",
                                                        textAlign: TextAlign.start,
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w900,
                                                      ))),
                                              TableCell(
                                                  child: Padding(
                                                padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                child: CustomWidgets.text(
                                                  paymentController.eventPayInfoData.value.venue.toString(),
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
                                                child: paymentController.eventPayInfoData.value.date.toString() != "" &&
                                                        paymentController.eventPayInfoData.value.date.toString() != null
                                                    ? CustomWidgets.text(
                                                        paymentController.eventPayInfoData.value.date.toString(),
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

                                            ///book time
                                            TableRow(children: [
                                              TableCell(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                      child: CustomWidgets.text(
                                                        "Doors Open Time",
                                                        textAlign: TextAlign.start,
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w900,
                                                      ))),
                                              TableCell(
                                                  child: Padding(
                                                padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                child: paymentController.eventPayInfoData.value.time!.isNotEmpty &&
                                                        paymentController.eventPayInfoData.value.time != null
                                                    ? CustomWidgets.text(
                                                        paymentController.eventPayInfoData.value.entryTime.toString(),
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

                                            ///book time
                                            TableRow(children: [
                                              TableCell(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                      child: CustomWidgets.text(
                                                        "Event Starts Time",
                                                        textAlign: TextAlign.start,
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w900,
                                                      ))),
                                              TableCell(
                                                  child: Padding(
                                                padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                child: paymentController.eventPayInfoData.value.time!.isNotEmpty &&
                                                        paymentController.eventPayInfoData.value.time != null
                                                    ? CustomWidgets.text(
                                                        paymentController.eventPayInfoData.value.time.toString(),
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
                                                        "Ticket Type",
                                                        textAlign: TextAlign.start,
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w900,
                                                      ))),
                                              TableCell(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                      child: CustomWidgets.text(
                                                        paymentController.eventPayInfoData.value.ticketType.toString(),
                                                        textAlign: TextAlign.start,
                                                        fontSize: 11.sp,
                                                      ))),
                                            ]),

                                            ///total booked hour
                                            TableRow(children: [
                                              TableCell(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                      child: CustomWidgets.text(
                                                        "Ticket Quantity",
                                                        textAlign: TextAlign.start,
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w900,
                                                      ))),
                                              TableCell(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                      child: CustomWidgets.text(
                                                        paymentController.eventPayInfoData.value.ticketQuantity.toString(),
                                                        textAlign: TextAlign.start,
                                                        fontSize: 11.sp,
                                                      ))),
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
                                                child: paymentController.eventPayInfoData.value.ticketType == "free"
                                                    ? const Text("0")
                                                    : paymentController.eventPayInfoData.value.totalAmount.toString() != "" &&
                                                            paymentController.eventPayInfoData.value.totalAmount.toString() != null
                                                        ? CustomWidgets.text(
                                                            paymentController.eventPayInfoData.value.totalAmount.toString(),
                                                            textAlign: TextAlign.start,
                                                            fontWeight: FontWeight.w900,
                                                            fontSize: 11.sp,
                                                          )
                                                        : const Text("0"),
                                              )),
                                            ]),
                                          ],
                                        ))
                                    : Container(),
                                SizedBox(
                                  height: 2.h,
                                ),
                                const Spacer(),
                                CustomButton(
                                  text: paymentController.eventPayInfoData.value.ticketType == "free"
                                      ? "Book Now"
                                      : "Pay ${paymentController.eventPayInfoData.value.totalAmount.toString()} AED",
                                  width: 90.w,
                                  onPressed: () {
                                    String checkUserRole = getuserRole();
                                    if (checkUserRole == "superAdmin") {
                                      bookingController.eventTicBookAPI(
                                          UserId: LoginSuccessModel.fromJson(
                                            GetStorage().read(
                                              userData,
                                            ),
                                          ).data!.sId.toString(),
                                          eventId: eventId,
                                          quantity: paymentController.eventPayInfoData.value.ticketQuantity!,
                                          payment: "",
                                          ticketType: "paid");
                                    } else {
                                      if (paymentController.eventPayInfoData.value.ticketType == "free") {
                                        bookingController.eventTicBookAPI(
                                            UserId: LoginSuccessModel.fromJson(
                                              GetStorage().read(
                                                userData,
                                              ),
                                            ).data!.sId.toString(),
                                            eventId: eventId,
                                            quantity: paymentController.eventPayInfoData.value.ticketQuantity!,
                                            payment: "",
                                            ticketType: "free");
                                      } else {
                                        Platform.isIOS
                                            ? applePaymentSheet(
                                                context, titleText: "For Book Your Hours",
                                                bookAmount: paymentController.eventPayInfoData.value.totalAmount.toString(),
                                                bookingLabel: paymentController.eventPayInfoData.value.name.toString(),
                                                discountAmount: "0",
                                                amount: paymentController.eventPayInfoData.value.totalAmount.toString(),
                                                onTapPaytabs: () {
                                                  bookingController.eventTicBookAPI(
                                                      UserId: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                      eventId: eventId,
                                                      quantity: paymentController.eventPayInfoData.value.ticketQuantity!,
                                                      payment: "",
                                                      ticketType: "paid");
                                                },
                                                onPressedApple: () {
                                                  bookingController.eventTicBookAPI(
                                                      UserId: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                      eventId: eventId,
                                                      quantity: paymentController.eventPayInfoData.value.ticketQuantity!,
                                                      payment: "applePay",
                                                      ticketType: "paid");
                                                },
                                                bookingIdScreen: "eventconcert",
                                                // bookId: bookingController.eventBookingDetails.value.bookingId.toString()
                                              )

                                            /// Android
                                            : bookingController.eventTicBookAPI(
                                                UserId: LoginSuccessModel.fromJson(
                                                  GetStorage().read(
                                                    userData,
                                                  ),
                                                ).data!.sId.toString(),
                                                eventId: eventId,
                                                quantity: paymentController.eventPayInfoData.value.ticketQuantity!,
                                                payment: "",
                                                ticketType: "paid");
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          ))
                        : CustomWidgets.NoInertnet(top: 200),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
