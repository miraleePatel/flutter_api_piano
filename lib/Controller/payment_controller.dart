// ignore_for_file: unused_import, unnecessary_brace_in_string_interps, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Data/Api/post_api_manager.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/Booking/payment_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Data/Api/api_manager.dart';
import '../Data/Model/apple_pay_response_model.dart';
import '../Data/Model/apple_payment_model.dart';
import '../Data/Model/concert_pay_details_model.dart';
import '../Data/Model/event_booking_response_model.dart';
import '../Data/Model/event_concert_payment_info_model.dart';
import '../Data/Model/payment_info_model.dart';
import '../Data/Model/payment_responce_model.dart';
import '../Data/Model/time_available_model.dart';
import '../Repository/booking_repository.dart';
import '../Repository/payment_repository.dart';
import '../Utils/constant_widgets.dart';
import '../Utils/string_constants.dart';
import 'booking_controller.dart';

class PaymentController extends GetxController {
  final paymentRepository = PaymentRepository(APIManager(), PostAPIManager());

//********************** variable declaration **********************//

  Rx<PaymentResponceModel> paymentDetails = PaymentResponceModel().obs;
  Rx<ApplePaymentModel> applePaymentDetails = ApplePaymentModel().obs;
  Rx<ApplePayResponseModel> applePayResponseModel = ApplePayResponseModel().obs;
  Rx<TokenModel> tokenModel = TokenModel().obs;
  Map<String, dynamic>? responseData;
  Rx<PaymentInfoModel> paymentInfoModel = PaymentInfoModel().obs;
  Rx<PaymentInfoData> paymentInfoData = PaymentInfoData().obs;
  Rx<ConcertPayDetailsModel> conPayInfoModel = ConcertPayDetailsModel().obs;
  Rx<ConcertPayData> conPayInfoData = ConcertPayData().obs;
  Rx<EventConcertPaymentInfoModel> eventPayInfoModel = EventConcertPaymentInfoModel().obs;
  Rx<EventPaymentData> eventPayInfoData = EventPaymentData().obs;

//********************** calling api in Payment screen **********************//

  //paytab 
  paytabsPaymentResponse({
    required String bookingId,
  }) async {
    paymentDetails.value = (await paymentRepository.paymentResponceAPICall(
      bookingId: bookingId,
    ));

    // success message & naviget page
    if (paymentDetails.value.status == 1) {
      Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      successSnackBar(message: paymentDetails.value.message);
    } else {
      errorSnackBar(message: paymentDetails.value.message);
      Get.offAllNamed(Routes.DASHBOARD_SCREEN);
    }
  }

  //apple pay
  applePaymentResponse({
    required String paymentStatus,
    required String transactionId,
    required String paymentMethod,
    required String cardType,
    required String paymentDescription,
    required String amount,
    required String bookingId,
  }) async {
    applePaymentDetails.value = (await paymentRepository.applePaymentAPICall(
        paymentStatus: paymentStatus,
        transactionId: transactionId,
        paymentMethod: paymentMethod,
        cardType: cardType,
        paymentDescription: paymentDescription,
        amount: amount,
        bookingId: bookingId));

    // success message & naviget page
    if (applePaymentDetails.value.status == 1) {
      Get.toNamed(Routes.APPLE_SUCCESSFULL_SCREEN);
    } else {
      Get.toNamed(Routes.APPLE_FAILED_SCREEN);
    }
  }


  //********************** studio payment information **********************//

  studioPaymentInfokAPI({
    required String userId,
    required String studioID,
    List? timeslot,
    String? date,
    required String plan,
  }) async {
    //call api
    paymentInfoModel.value = await paymentRepository.paymentInfoAPICall(
      studioID: studioID,
      plan: plan,
      date: date,
      timeslot: timeslot,
      userId: userId,
    );
    // success message & navigation
    if (paymentInfoModel.value.data != null) {
      paymentInfoData.value = paymentInfoModel.value.data!;
    }
  }

//********************** concert payment information **********************//

  concertPaymentInfokAPI({
    required String userId,
    required String concertID,
    String? date,
    List? timeslot,
    required String plan,
  }) async {
    //call api
    conPayInfoModel.value = await paymentRepository.concertPayInfoAPICall(
      userId: userId,
      concertID: concertID,
      plan: plan,
      date: date,
      timeslot: timeslot,
    );

    // success message & navigation
    if (conPayInfoModel.value.data != null) {
      conPayInfoData.value = conPayInfoModel.value.data!;
      // success message
    }
  }

//********************** Event & Concert payment information **********************//

  eventPaymentInfokAPI({
    required String userId,
    required String eventId,
    required int quantity,
  }) async {
    //call api
    eventPayInfoData.value = EventPaymentData();
    eventPayInfoModel.value = await paymentRepository.eventPaymentInfoAPICall(userId: userId, eventId: eventId, quantity: quantity);

    // success message & navigation
    if (eventPayInfoModel.value.status == 1) {
      Get.toNamed(Routes.EVENT_CONCERT_PAYMENT_INFO_SCREEN, arguments: eventId);
      if (eventPayInfoModel.value.data != null) {
        eventPayInfoData.value = eventPayInfoModel.value.data!;
        // success message
      }
    } else {
      errorSnackBar(message: eventPayInfoModel.value.message);
    }
  }

  }
