// ignore_for_file: unused_import","unnecessary_brace_in_string_interps","non_constant_identifier_names","unnecessary_null_comparison","unused_field","prefer_typing_uninitialized_variables, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, unnecessary_null_comparison, non_constant_identifier_names, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Data/Api/post_api_manager.dart';
import 'package:piano_project/Data/Model/concert_hall_booking_model.dart';
import 'package:piano_project/Data/Model/studio_booking_model.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:time_range/time_range.dart';
import '../Data/Api/api_manager.dart';
import '../Data/Model/event_booking_response_model.dart';
import '../Data/Model/studio_wallet_recharge_model.dart';
import '../Data/Model/time_available_model.dart';
import '../Repository/booking_repository.dart';
import '../Utils/constant_widgets.dart';

class BookingController extends GetxController {
  final bookingRepository = BookingRepository(APIManager(), PostAPIManager());

//********************** variable declaration **********************//

  Rx<EventBookingResponseModel> eventBookingDetails = EventBookingResponseModel().obs;
  Rx<ConcertHallBookingModel> concertBookingDetails = ConcertHallBookingModel().obs;
  Rx<StudioBookingModel> studioBookingDetails = StudioBookingModel().obs;
  Rx<TimeAvailableModel> timeAvailableModel = TimeAvailableModel().obs;
  Rx<StudioWalletRechargeModel> studioWalletRechargeModel = StudioWalletRechargeModel().obs;

  List timeList = [];
  TimeRangeResult? timeRange;
  List list = [];
  RxBool agree = false.obs;
  RxList totalHours = [].obs;
  var staticstarttime;
  var staticendtime;
  Rx remainingHour = 0.obs;
  Rx remaining25Hour = 0.obs;
  Rx remaining50Hour = 0.obs;
  List<String> staticList = [];
  List tempList = [];
  List availablTimeList = [];
  List<String> timeSlots = [];
  List<String> staticavailableTimeList = [];
  List selectTimeList = [];
  RxString concertBookId = "".obs;
  RxString studioBookId = "".obs;

  //********************** function  **********************//

  // default time
  final defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 00, minute: 00),
    const TimeOfDay(hour: 00, minute: 00),
  );

  // TimeFormate({required String time}){
  //   var temp = int.parse(time.split(':')[0]);
  // String? t;
  // if(temp >= 12 && temp <24){
  //   t = " PM";
  // }
  // else{
  //   t = " AM";
  // }
  // if (temp > 12) {
  //   temp = temp - 12;
  //   if (temp < 10) {
  //     time = time.replaceRange(0, 2, "0$temp");
  //     time += t;
  //   } else {
  //     time = time.replaceRange(0, 2, "$temp");
  //     time += t;
  //   }
  // } else if (temp == 00) {
  //   time = time.replaceRange(0, 2, '12');
  //   time += t;
  // }else{
  //   time += t;
  // }

  // print("Time =========> ${time}");
  // }

  //crate time list
  Iterable<TimeOfDay> getTimes(TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
      if (hour >= 24) {
        hour -= 24;
      }
      final start = TimeOfDay(hour: hour, minute: minute);
    } while (hour < endTime.hour || (hour == endTime.hour && minute <= endTime.minute));
  }

  //compere list
  bool listContainsAll<T>(List<T> a, List<T> b) {
    final setA = Set.of(a);
    log('.......${setA.containsAll(b)}');
    return setA.containsAll(b);
  }

  //add time
  List<String> generateTimeSlots() {
    DateTime startTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 8);
    DateTime endTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 21);

    while (startTime.isBefore(endTime)) {
      DateTime slotStart = startTime;
      DateTime slotEnd = startTime.add(const Duration(hours: 1));
      timeSlots.add('${formatTime(slotStart)} to ${formatTime(slotEnd)}');

      startTime = startTime.add(const Duration(hours: 1));
    }

    return timeSlots;
  }

  //set time formate
  String formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    return '$hour:00';
  }

  //gerate list in next time
  String getNextHour(String time) {
    DateTime currentTime = DateTime.parse('2023-07-05 $time:00');
    DateTime nextHour = currentTime.add(const Duration(hours: 1));
    return nextHour.hour.toString().padLeft(2, '0') + ':00';
  }

  //get list
  listget({required List timelist}) {
    staticavailableTimeList.clear();
    staticavailableTimeList = generateTimeSlots();

    int index;
    staticList.clear();
    tempList.clear();
    availablTimeList.clear();

    var n = staticavailableTimeList.length - 1;
    print(n);
    for (int i = 1; i < n; i++) {
      staticList.add(staticavailableTimeList[i]);
    }

    var n1 = timelist.length - 1;
    for (int i = 0; i < n1; i++) {
      staticstarttime = timelist[i];
      staticendtime = getNextHour(staticstarttime);
      tempList.add("${staticstarttime} to ${staticendtime}");
    }

    for (var item in staticList) {
      if (tempList.contains(item)) {
        availablTimeList.add(item);
      } else {
        print('list is empty');
      }
    }
  }

  //********************** calling api in schedule screen **********************//

  timeAvalibaleApi({required String id, required String selectdate}) async {
    timeList.clear();
    //set time foramte[current time & date]
    var currentDate = DateTime.now();
    var currentTime = "${currentDate.hour} : ${currentDate.minute}";
    var newcurrentDate = DateFormat("yyyy-MM-dd").parse(currentDate.toString());
    var date2 = DateFormat('dd/MM/yyyy').format(DateTime.parse(newcurrentDate.toString()));
    var currentdatetime = '${date2} ${currentTime}';

    //call api
    timeAvailableModel.value = await bookingRepository.TimeSlotAPICall(
      currentdatetime: currentdatetime,
      Id: id,
      date: selectdate,
    );

    // success message & navigation
    if (timeAvailableModel.value.status == 1) {
      Get.toNamed(
        Routes.SHEDULE_SCREEN,
        arguments: [id.toString(), timeAvailableModel.value.data, selectdate, "concertscreen", false, ""],
      );
    }
  }

//********************** calling api in events & concerts screen **********************//

  eventTicBookAPI({
    required String UserId,
    required String eventId,
    required int quantity,
    required String payment,
    required String ticketType,
  }) async {
    //call api

    eventBookingDetails.value = await bookingRepository.eventTicBookAPICall(userId: UserId, eventId: eventId, quantity: quantity, payment: payment);

    // success message & navigation
    if (eventBookingDetails.value.status == 1) {
      if (kDebugMode) {
        print("url ::::: ${eventBookingDetails.value.paymentUrl}");
      }
      if (eventBookingDetails.value.paymentUrl == null) {
        if (ticketType == "free") {
          successSnackBar(message: eventBookingDetails.value.message);
          Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        }
      } else {
        Get.toNamed(Routes.PAYMENT_SCREEN, arguments: [
          eventBookingDetails.value.paymentUrl,
          eventBookingDetails.value.bookingId,
        ]);
      }
    } else {
      informationSnackBar(message: eventBookingDetails.value.message);
      log(eventBookingDetails.value.paymentUrl.toString());
    }
  }

//********************** calling api in concerts hall screen **********************//

  concerthallBookAPI({
    required String userId,
    required String concertId,
    required List timeslot,
    required String date,
    required String payment,
    required String plan,
    String? schoolname,
    String? teachersname,
    String? performersno,
    String? guestsno,
    bool isBooking = false,
  }) async {
    //call api

    concertBookingDetails.value = await bookingRepository.concerthallBookAPICall(
      concertId: concertId,
      date: date,
      timeslot: timeslot,
      userId: userId,
      concertBookingDetail: isBooking
          ? {
              "school_name": schoolname,
              "teachers_name": teachersname,
              "numbers_of_performers": performersno,
              "numbers_of_guests": guestsno,
            }
          : {},
      payment: payment,
      plan: plan,
    );
    //

    // success message & navigation
    if (concertBookingDetails.value.status == 1) {
      if (concertBookingDetails.value.paymentUrl != null) {
        Get.toNamed(Routes.PAYMENT_SCREEN, arguments: [
          concertBookingDetails.value.paymentUrl,
          concertBookingDetails.value.bookingId,
        ]);
      } else {
        if (payment != "applePay") {
          successSnackBar(message: concertBookingDetails.value.message);
          Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        }
      }
    } else {
      informationSnackBar(message: concertBookingDetails.value.message);
      log(concertBookingDetails.value.paymentUrl.toString());
    }

    update();
  }

//********************** calling api in studio screen **********************//
  studioBookAPI({
    required String userId,
    required String studioID,
    List? timeslot,
    String? walletId,
    String? date,
    required String plan,
    required String payment,
  }) async {
    //call api
    studioBookId.value = "";

    studioBookingDetails.value = await bookingRepository.studioBookAPICall(
        userId: userId, studioID: studioID, timeslot: timeslot, walletId: walletId, payment: payment, date: date, plan: plan);
    // studioBookAPICall(studioID: studioID, plan: plan, date: date, timeslot: timeslot, userId: userId, payment: payment);

    // success message & navigation
    if (studioBookingDetails.value.status == 1) {
      //hourly plan
      print(studioBookingDetails.value.bookingId);
      studioBookId.value = studioBookingDetails.value.bookingId.toString();
      print(studioBookId.value);
      if (studioBookingDetails.value.paymentUrl == null) {
        if (payment == "applePay") {
          // successSnackBar(message: studioBookingDetails.value.message);
          studioBookId.value = studioBookingDetails.value.bookingId.toString();
          print('booking id ::: ${studioBookId.value}');
        } else {
          successSnackBar(message: studioBookingDetails.value.message);
          Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        }
      } else {
        Get.toNamed(Routes.PAYMENT_SCREEN, arguments: [
          studioBookingDetails.value.paymentUrl,
          studioBookingDetails.value.bookingId,
        ]);
      }
    } else {
      // informationSnackBar(message: studioBookingDetails.value.message);
      log(studioBookingDetails.value.paymentUrl.toString());
    }
    update();
  }

//********************** calling api in studio rental screen **********************//

  studiotimeAvalibaleApi({required String id, required String selectdate, required String plan}) async {
    timeList.clear();

    //set time foramte[current time & date]
    var currentDate = DateTime.now();
    var currentTime = DateFormat.jm().format(currentDate);
    var newcurrentDate = DateFormat("yyyy-MM-dd").parse(currentDate.toString());
    var date2 = DateFormat('dd/MM/yyyy').format(DateTime.parse(newcurrentDate.toString()));
    var currentdatetime = '${date2} ${currentTime}';

    //call api
    timeAvailableModel.value = await bookingRepository.StudioTimeSlotAPICall(
      currentdatetime: currentdatetime,
      Id: id,
      date: selectdate,
      model: 'StudioRentals',
    );

    // success message & navigation

    if (timeAvailableModel.value.status == 1) {
      Get.toNamed(Routes.SHEDULE_SCREEN, arguments: [id.toString(), timeAvailableModel.value.data, selectdate, "studioscreen", plan]);
    }
  }

//********************** calling api in wallet balance screen **********************//

  studioWalletRechargeApi({
    required String userId,
    required String walletId,
    required String hour,
    required int price,
    required String payment,
  }) async {
    //call api
    studioWalletRechargeModel.value =
        await bookingRepository.studioWalletRechargeAPICall(userId: userId, walletId: walletId, hour: hour, price: price, payment: payment);

    // success message & navigation

    if (studioWalletRechargeModel.value.status == 1 || studioWalletRechargeModel.value.bookingId != null) {
      studioWalletRechargeModel.value.paymentUrl != null
          ? Get.toNamed(Routes.PAYMENT_SCREEN, arguments: [
              studioWalletRechargeModel.value.paymentUrl,
              studioWalletRechargeModel.value.bookingId,
            ])
          : null;
    } else {
      informationSnackBar(message: studioWalletRechargeModel.value.message);
      log(studioWalletRechargeModel.value.paymentUrl.toString());
    }
    update();
  }
}
