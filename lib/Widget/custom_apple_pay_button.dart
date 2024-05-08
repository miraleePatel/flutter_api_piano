// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:piano_project/Controller/booking_controller.dart';
import '../Controller/payment_controller.dart';

class CustomApplePayButton extends StatefulWidget {
  String? amount;
  String? discountAmount;
  String? bookingLabel;
  String? bookAmount;
  Function()? onPressed;
  String? bookingIdScreen;
  // String? bookId;

  CustomApplePayButton({super.key, this.amount, this.onPressed, this.bookingIdScreen, this.bookAmount, this.bookingLabel, this.discountAmount});

  @override
  State<CustomApplePayButton> createState() => _CustomApplePayButtonState();
}

class _CustomApplePayButtonState extends State<CustomApplePayButton> {
  BookingController bookingController = Get.put(BookingController());
  PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return ApplePayButton(
      // ignore: deprecated_member_use
      paymentConfigurationAsset: 'applepay.json',
      paymentItems: [
        PaymentItem(
          label: "${widget.bookingLabel} Booking",
          amount: widget.bookAmount!, // Replace with the actual amount
          status: PaymentItemStatus.final_price,
        ),
        PaymentItem(
            label: "Discount",
            // Replace with the actual amount
            // status: PaymentItemStatus.unknown,
            amount: widget.discountAmount!,
            type: PaymentItemType.item),
        PaymentItem(
          label: 'House of pianos',
          amount: widget.amount!,
          status: PaymentItemStatus.final_price,
        ),
      ],
      style: ApplePayButtonStyle.black,
      type: ApplePayButtonType.plain,
      width: 300,
      height: 50,
      margin: const EdgeInsets.only(top: 15.0),
      onPressed: widget.onPressed,
      onPaymentResult: (Map<String, dynamic> value) {
        print("Response type: ${value.runtimeType}");
        print("Response --------------->");
        print(value);
        paymentController.responseData = value;
        print("----------------------------------------------\n");
        print('---------------Payment Method Network: ${paymentController.responseData!['paymentMethod']['network']}');

        print("Booking id ---------------> ${bookingController.studioBookId.value}");

        paymentController.applePaymentResponse(
            paymentStatus: "success",
            transactionId: paymentController.responseData!['transactionIdentifier'],
            paymentMethod: "applepay",
            cardType: paymentController.responseData!['paymentMethod']['network'],
            paymentDescription: paymentController.responseData!['paymentMethod']['displayName'].toString().split(" ").last,
            amount: widget.amount!,
            bookingId: widget.bookingIdScreen == "concerthall"
                ? bookingController.concertBookingDetails.value.bookingId.toString()
                : widget.bookingIdScreen == "eventconcert"
                    ? bookingController.eventBookingDetails.value.bookingId.toString()
                    : widget.bookingIdScreen == "package"
                        ? bookingController.studioWalletRechargeModel.value.bookingId.toString()
                        /*  : widget.bookingIdScreen == "studioRental"
                                ? bookingController.studioBookingDetails.value.bookingId.toString() */
                        : "");
        Get.back(closeOverlays: true);
      },
      onError: (error) {
        print("error --------------->");
        print(error);
        print(bookingController.studioBookingDetails.value.bookingId.toString());
        print("error --------------->");
        Get.back(closeOverlays: true);

        paymentController.applePaymentResponse(
            paymentStatus: "failed",
            transactionId: "",
            paymentMethod: "",
            cardType: "",
            paymentDescription: "",
            amount: widget.amount!,
            bookingId: widget.bookingIdScreen == "concerthall"
                ? bookingController.concertBookingDetails.value.bookingId.toString()
                : widget.bookingIdScreen == "eventconcert"
                    ? bookingController.eventBookingDetails.value.bookingId.toString()
                    : widget.bookingIdScreen == "package"
                        ? bookingController.studioWalletRechargeModel.value.bookingId.toString()
                        /*   : widget.bookingIdScreen == "studioRental"
                                ? bookingController.studioBookingDetails.value.bookingId.toString() */
                        : "");
      },
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
//  studioBookId.value