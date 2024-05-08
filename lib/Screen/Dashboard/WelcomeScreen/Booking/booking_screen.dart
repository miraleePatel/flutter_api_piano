// ignore_for_file: unused_import, unnecessary_brace_in_string_interps, avoid_print, unnecessary_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Controller/booking_controller.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:piano_project/Widget/custom_datepicker.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/calender_controller.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_textfield.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TableCalenderController tableCalenderController =
      Get.put(TableCalenderController());
  BookingController bookingController = Get.put(BookingController());
  String id = Get.arguments[0];
  String screenname = Get.arguments[1];
  String plan = Get.arguments[2];
  @override
  void dispose() {
    super.dispose();
    tableCalenderController.selectedDate.value = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: CustomColor.btnAbout,
          body: Column(
            children: [
              CustomWidgets.CustAppbar(
                title: "Booking",
              ),
            Obx(() {
               // no internet connection
                return isInternetAvailable.value == true
                    ?
                      Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    CustomWidgets.text(
                      'Select a Day',
                      fontSize: 12.sp,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: const CustomDatePicker(),
                    ),
                    const Spacer(),
                    CustomButton(
                      width: 90.w,
                      onPressed: () {
                        tableCalenderController.selectedDate;

                        var date = tableCalenderController.selectedDate.value
                            .toString()
                            .split(" ")
                            .first;

                        var newDate =
                            DateFormat("yyyy-MM-dd").parse(date.toString());

                        date = DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(newDate.toString()));
                        print('selcte date ::::: ${date}');
                        if (screenname == "concertscreen") {
                          bookingController.timeAvalibaleApi(
                              id: id, selectdate: date);
                        } else {
                          print('studio rental screen');
                          bookingController.studiotimeAvalibaleApi(
                              plan: plan, id: id, selectdate: date);
                        }
                      },
                        text: 'Proceed',
                    ),
                  ],
                ),
              )
               : CustomWidgets.NoInertnet(top: 200);
              }),
              SizedBox(
                height: 3.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
