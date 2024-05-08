// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../Data/Model/get_activity_model.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/string_constants.dart';
import '../../../Widget/custom_widget.dart';

class BookActivityDetailsScreen extends StatefulWidget {
  const BookActivityDetailsScreen({super.key});

  @override
  State<BookActivityDetailsScreen> createState() => _BookActivityDetailsScreenState();
}

class _BookActivityDetailsScreenState extends State<BookActivityDetailsScreen> {
  Activity activity = Get.arguments[0];
  var dateData = Get.arguments[1];
  String formatDate(String inputDate) {
    final parsedDate = DateFormat('dd/MM/yyyy').parse(inputDate);
    final formattedDate = DateFormat('dd MMM, yyyy', 'en_US').format(parsedDate);
    return formattedDate;
  }

  String getNextHour(String time) {
    DateTime currentTime = DateTime.parse('2023-07-05 $time:00');
    DateTime nextHour = currentTime.add(const Duration(hours: 1));
    return nextHour.hour.toString().padLeft(2, '0') + ':00';
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
              Image.asset(
                backgroundImage,
              ),
              activity.bookingDetail != null
                  ? Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomWidgets.CustAppbar(
                            title: "My Activity",
                          ),
                          // No internet connection
                          isInternetAvailable.value == true
                              ? Expanded(
                                  child: CustomWidgets.customContainer(
                                    margintop: 2.h,
                                    top: 15.h,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        left: 2.h,
                                        right: 2.h,
                                        bottom: 2.h,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            // studio rental booking activity
                                            activity.bookingDetail!.bookedService!.serviceName == "Studio Rentals"
                                                ? Column(
                                                    children: [
                                                      CustomWidgets.text(
                                                        activity.bookingDetail!.bookedService!.serviceName.toString(),
                                                        textAlign: TextAlign.center,
                                                        fontSize: 15.sp,
                                                        color: CustomColor.btn,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        activity.title.toString(),
                                                        textAlign: TextAlign.center,
                                                        fontSize: 13.sp,
                                                        color: CustomColor.btn,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      SizedBox(
                                                        height: 35.h,
                                                        width: double.infinity,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(
                                                            5,
                                                          ),
                                                          child: (activity.bookingDetail!.bookedService!.service!.file != null)
                                                              ? CustomWidgets.customImage(
                                                                  fit: BoxFit.fill,
                                                                  image: activity.bookingDetail!.bookedService!.service!.file.toString())
                                                              : CustomWidgets.NoImage(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.all(10),
                                                        child: Table(
                                                          border: TableBorder.all(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.grey.shade300,
                                                          ),
                                                          children: [
                                                            TableRow(
                                                              children: [
                                                                /// STUDIO NAME
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Studio Name",
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                      fontWeight: FontWeight.w900,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      activity.bookingDetail!.bookedService!.service!.name.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            /// reg date
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Registration Date",
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                      fontWeight: FontWeight.w900,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      dateData,
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            /// Address
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Address",
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                      fontWeight: FontWeight.w900,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TableCell(
                                                                    child: Padding(
                                                                  padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                  child: CustomWidgets.text(
                                                                    activity.bookingDetail!.bookedService!.service!.address.toString(),
                                                                    textAlign: TextAlign.start,
                                                                    fontSize: 11.sp,
                                                                  ),
                                                                )),
                                                              ],
                                                            ),

                                                            /// Book Date
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Book Date",
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                      fontWeight: FontWeight.w900,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                    child: activity.bookingDetail!.studioBookPlan.toString() != "10hour"
                                                                        ? (activity.bookingDetail!.bookHourlyTimeSlot!.isNotEmpty
                                                                            ? CustomWidgets.text(
                                                                                formatDate(activity.bookingDetail!.bookHourlyTimeSlot!.first
                                                                                    .split(" ")
                                                                                    .first),
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              )
                                                                            : CustomWidgets.text(
                                                                                "-",
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              ))
                                                                        : (activity.bookSlot!.isNotEmpty
                                                                            ? CustomWidgets.text(
                                                                                formatDate(activity.bookSlot!.first.split(" ").first),
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              )
                                                                            : CustomWidgets.text(
                                                                                "-",
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              )),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            /// Time Slot
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          "Book Hourly Time Slot",
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                          fontWeight: FontWeight.w900,
                                                                        ))),
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                    child: (activity.bookingDetail!.studioBookPlan.toString() != "10hour")
                                                                        ? (activity.bookingDetail!.bookHourlyTimeSlot!.isNotEmpty
                                                                            ? activity.bookingDetail!.bookHourlyTimeSlot!.length == 1
                                                                                ? CustomWidgets.text(
                                                                                    "${activity.bookingDetail!.bookHourlyTimeSlot!.first.split(" ").last} - ${getNextHour(activity.bookingDetail!.bookHourlyTimeSlot!.first.split(" ").last)}",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                  )
                                                                                : CustomWidgets.text(
                                                                                    "${activity.bookingDetail!.bookHourlyTimeSlot!.first.split(" ").last} - ${getNextHour(activity.bookingDetail!.bookHourlyTimeSlot!.last.split(" ").last)}",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                  )
                                                                            : CustomWidgets.text(
                                                                                "-",
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              ))
                                                                        : (activity.bookSlot!.isNotEmpty
                                                                            ? activity.bookSlot!.length == 1
                                                                                ? CustomWidgets.text(
                                                                                    "${activity.bookSlot!.first.split(" ").last} - ${getNextHour(activity.bookSlot!.first.split(" ").last)}",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                  )
                                                                                : CustomWidgets.text(
                                                                                    "${activity.bookSlot!.first.split(" ").last} - ${getNextHour(activity.bookSlot!.last.split(" ").last)}",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                  )
                                                                            : CustomWidgets.text(
                                                                                "-",
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              )),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            ///plan
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Discount",
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                      fontWeight: FontWeight.w900,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                    child: activity.bookingDetail!.bookByTeacher == true
                                                                        ? CustomWidgets.text(
                                                                            "50%",
                                                                            textAlign: TextAlign.start,
                                                                            fontSize: 11.sp,
                                                                          )
                                                                        : CustomWidgets.text(
                                                                            "0%",
                                                                            textAlign: TextAlign.start,
                                                                            fontSize: 11.sp,
                                                                          ),
                                                                  ),
                                                                ),
                                                                //
                                                              ],
                                                            ),

                                                            ///plan
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Plan",
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                      fontWeight: FontWeight.w900,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                    child: activity.bookingDetail!.studioBookPlan != "bookByWallet"
                                                                        ? CustomWidgets.text(
                                                                            activity.bookingDetail!.studioBookPlan.toString(),
                                                                            textAlign: TextAlign.start,
                                                                            fontSize: 11.sp,
                                                                          )
                                                                        : CustomWidgets.text(
                                                                            "Book using wallet",
                                                                            textAlign: TextAlign.start,
                                                                            fontSize: 11.sp,
                                                                          ),
                                                                  ),
                                                                ),
                                                                //
                                                              ],
                                                            ),

                                                            /// payment amount
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          "Payment Amount",
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                          fontWeight: FontWeight.w900,
                                                                        ))),
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                    child: activity.bookingDetail!.payment!.isNotEmpty
                                                                        ? CustomWidgets.text(
                                                                            activity.bookingDetail!.payment![0].paymentAmount.toString(),
                                                                            textAlign: TextAlign.start,
                                                                            fontSize: 11.sp,
                                                                          )
                                                                        : CustomWidgets.text(
                                                                            "0",
                                                                            textAlign: TextAlign.start,
                                                                            fontSize: 11.sp,
                                                                          ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                //concert hall bokking activity
                                                : activity.bookingDetail!.bookedService!.serviceName == "Concert Hall"
                                                    ? Column(
                                                        children: [
                                                          CustomWidgets.text(
                                                            activity.bookingDetail!.bookedService!.serviceName.toString(),
                                                            textAlign: TextAlign.center,
                                                            fontSize: 15.sp,
                                                            color: CustomColor.btn,
                                                            fontWeight: FontWeight.w800,
                                                          ),
                                                          SizedBox(
                                                            height: 1.h,
                                                          ),
                                                          CustomWidgets.text(
                                                            activity.title.toString(),
                                                            textAlign: TextAlign.center,
                                                            fontSize: 13.sp,
                                                            color: CustomColor.btn,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          SizedBox(
                                                            height: 2.h,
                                                          ),
                                                          SizedBox(
                                                            height: 35.h,
                                                            width: double.infinity,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(
                                                                5,
                                                              ),
                                                              child: (activity.bookingDetail!.bookedService!.service!.file != null)
                                                                  ? CustomWidgets.customImage(
                                                                      fit: BoxFit.fill,
                                                                      image: activity.bookingDetail!.bookedService!.service!.file.toString())
                                                                  : CustomWidgets.NoImage(),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 2.h,
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(10),
                                                            child: Table(
                                                              border: TableBorder.all(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: Colors.grey.shade300,
                                                              ),
                                                              children: [
                                                                TableRow(
                                                                  children: [
                                                                    /// STUDIO NAME
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          "Name",
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                          fontWeight: FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          activity.bookingDetail!.bookedService!.service!.name.toString(),
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                /// Regis date
                                                                TableRow(
                                                                  children: [
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          "Registration Date",
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                          fontWeight: FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          dateData,
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                /// Book Date
                                                                TableRow(
                                                                  children: [
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          "Book Date",
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                          fontWeight: FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                        child: activity.bookingDetail!.bookHourlyTimeSlot!.isNotEmpty
                                                                            ? CustomWidgets.text(
                                                                                formatDate(activity.bookingDetail!.bookHourlyTimeSlot!.first
                                                                                    .split(" ")
                                                                                    .first),
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              )
                                                                            : CustomWidgets.text(
                                                                                "-",
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                /// Time Slot
                                                                TableRow(
                                                                  children: [
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          "Book Hourly Time Slot",
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                          fontWeight: FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                        child: activity.bookingDetail!.bookHourlyTimeSlot!.isNotEmpty
                                                                            ? activity.bookingDetail!.bookHourlyTimeSlot!.length == 1
                                                                                ? CustomWidgets.text(
                                                                                    "${activity.bookingDetail!.bookHourlyTimeSlot!.first.split(" ").last} - ${getNextHour(activity.bookingDetail!.bookHourlyTimeSlot!.first.split(" ").last)}",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                  )
                                                                                : CustomWidgets.text(
                                                                                    "${activity.bookingDetail!.bookHourlyTimeSlot!.first.split(" ").last} - ${getNextHour(activity.bookingDetail!.bookHourlyTimeSlot!.last.split(" ").last)}",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                  )
                                                                            : CustomWidgets.text(
                                                                                "-",
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                /// Price
                                                                TableRow(
                                                                  children: [
                                                                    TableCell(
                                                                        child: Padding(
                                                                            padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                            child: CustomWidgets.text(
                                                                              "Price",
                                                                              textAlign: TextAlign.start,
                                                                              fontSize: 11.sp,
                                                                              fontWeight: FontWeight.w900,
                                                                            ))),
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          activity.bookingDetail!.bookedService!.service!.price.toString(),
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                /// payment amount
                                                                TableRow(
                                                                  children: [
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                        child: CustomWidgets.text(
                                                                          "Payment Amount",
                                                                          textAlign: TextAlign.start,
                                                                          fontSize: 11.sp,
                                                                          fontWeight: FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TableCell(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                        child: activity.bookingDetail!.payment!.isNotEmpty
                                                                            ? CustomWidgets.text(
                                                                                activity.bookingDetail!.payment![0].paymentAmount.toString(),
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              )
                                                                            : CustomWidgets.text(
                                                                                "0",
                                                                                textAlign: TextAlign.start,
                                                                                fontSize: 11.sp,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    //event & concert booking activity
                                                    : activity.bookingDetail!.bookedService!.serviceName == "Events and concert"
                                                        ? activity.bookingDetail!.bookedService!.service != null
                                                            ? Column(
                                                                children: [
                                                                  CustomWidgets.text(
                                                                    activity.bookingDetail!.bookedService!.serviceName.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    fontSize: 15.sp,
                                                                    color: CustomColor.btn,
                                                                    fontWeight: FontWeight.w800,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 1.h,
                                                                  ),
                                                                  CustomWidgets.text(
                                                                    activity.title.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    fontSize: 13.sp,
                                                                    color: CustomColor.btn,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 35.h,
                                                                    width: double.infinity,
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                      child: (activity.bookingDetail!.bookedService!.service!.file != null)
                                                                          ? CustomWidgets.customImage(
                                                                              fit: BoxFit.fill,
                                                                              image: activity.bookingDetail!.bookedService!.service!.file.toString())
                                                                          : CustomWidgets.NoImage(),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets.all(10),
                                                                    child: Table(
                                                                      border: TableBorder.all(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: Colors.grey.shade300,
                                                                      ),
                                                                      children: [
                                                                        TableRow(children: [
                                                                          /// Event NAME
                                                                          TableCell(
                                                                              child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                  child: CustomWidgets.text(
                                                                                    "Event Name",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ))),
                                                                          TableCell(
                                                                              child: Padding(
                                                                            padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                            child: CustomWidgets.text(
                                                                              activity.bookingDetail!.bookedService!.service!.name.toString(),
                                                                              textAlign: TextAlign.start,
                                                                              // overflow:
                                                                              //     TextOverflow
                                                                              //         .ellipsis ,
                                                                              fontSize: 11.sp,
                                                                            ),
                                                                          )),
                                                                        ]),

                                                                        /// date
                                                                        TableRow(children: [
                                                                          TableCell(
                                                                              child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                  child: CustomWidgets.text(
                                                                                    "Registration Date",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ))),
                                                                          TableCell(
                                                                              child: Padding(
                                                                            padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                            child: CustomWidgets.text(
                                                                              dateData,
                                                                              textAlign: TextAlign.start,
                                                                              // overflow:
                                                                              //     TextOverflow
                                                                              //         .ellipsis ,
                                                                              fontSize: 11.sp,
                                                                            ),
                                                                          )),
                                                                        ]),

                                                                        /// venue
                                                                        TableRow(children: [
                                                                          TableCell(
                                                                              child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
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
                                                                              activity.bookingDetail!.bookedService!.service!.venue.toString(),
                                                                              textAlign: TextAlign.start,
                                                                              // overflow:
                                                                              //     TextOverflow
                                                                              //         .ellipsis ,
                                                                              fontSize: 11.sp,
                                                                            ),
                                                                          )),
                                                                        ]),

                                                                        /// Book Date
                                                                        TableRow(children: [
                                                                          TableCell(
                                                                              child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                  child: CustomWidgets.text(
                                                                                    "Book Date",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ))),
                                                                          TableCell(
                                                                              child: Padding(
                                                                            padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                            child: activity.bookingDetail!.bookDate != null
                                                                                ? CustomWidgets.text(
                                                                                    formatDate(activity.bookingDetail!.bookDate.toString()),
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

                                                                        /// Time Slot
                                                                        TableRow(children: [
                                                                          TableCell(
                                                                              child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                  child: CustomWidgets.text(
                                                                                    "Book Time",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ))),
                                                                          TableCell(
                                                                              child: Padding(
                                                                            padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                            child: activity.bookingDetail!.bookTime != null
                                                                                ? CustomWidgets.text(
                                                                                    activity.bookingDetail!.bookTime.toString(),
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

                                                                        /// ticket type
                                                                        TableRow(children: [
                                                                          TableCell(
                                                                              child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
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
                                                                              activity.bookingDetail!.bookedService!.service!.ticketType.toString(),
                                                                              textAlign: TextAlign.start,
                                                                              // overflow:
                                                                              //     TextOverflow
                                                                              //         .ellipsis ,
                                                                              fontSize: 11.sp,
                                                                            ),
                                                                          )),
                                                                        ]),

                                                                        /// ticket type
                                                                        TableRow(children: [
                                                                          TableCell(
                                                                              child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
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
                                                                              activity.bookingDetail!.ticketQuantity.toString(),
                                                                              textAlign: TextAlign.start,
                                                                              // overflow:
                                                                              //     TextOverflow
                                                                              //         .ellipsis ,
                                                                              fontSize: 11.sp,
                                                                            ),
                                                                          )),
                                                                        ]),

                                                                        /// Ticket Price
                                                                        TableRow(children: [
                                                                          TableCell(
                                                                              child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                  child: CustomWidgets.text(
                                                                                    "Ticket Price",
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ))),
                                                                          TableCell(
                                                                              child: Padding(
                                                                            padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                            child: CustomWidgets.text(
                                                                              activity.bookingDetail!.bookedService!.service!.ticketPrice.toString(),
                                                                              textAlign: TextAlign.start,
                                                                              // overflow:
                                                                              //     TextOverflow
                                                                              //         .ellipsis ,
                                                                              fontSize: 11.sp,
                                                                            ),
                                                                          )),
                                                                        ]),

                                                                        /// payment amount
                                                                        activity.bookingDetail!.payment!.isNotEmpty
                                                                            ? TableRow(children: [
                                                                                TableCell(
                                                                                    child: Padding(
                                                                                        padding: EdgeInsets.only(
                                                                                            top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                        child: CustomWidgets.text(
                                                                                          "Payment Amount",
                                                                                          textAlign: TextAlign.start,
                                                                                          fontSize: 11.sp,
                                                                                          fontWeight: FontWeight.w900,
                                                                                        ))),
                                                                                TableCell(
                                                                                    child: Padding(
                                                                                  padding:
                                                                                      EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                  child: CustomWidgets.text(
                                                                                    activity.bookingDetail!.payment![0].paymentAmount.toString(),
                                                                                    textAlign: TextAlign.start,
                                                                                    fontSize: 11.sp,
                                                                                  ),
                                                                                )),
                                                                              ])
                                                                            : TableRow(
                                                                                children: [
                                                                                  TableCell(
                                                                                      child: Padding(
                                                                                          padding: EdgeInsets.only(
                                                                                              top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                          child: CustomWidgets.text(
                                                                                            "Payment Amount",
                                                                                            textAlign: TextAlign.start,
                                                                                            fontSize: 11.sp,
                                                                                            fontWeight: FontWeight.w900,
                                                                                          ))),
                                                                                  TableCell(
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(
                                                                                          top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                      child: CustomWidgets.text(
                                                                                        "0",
                                                                                        textAlign: TextAlign.start,
                                                                                        fontSize: 11.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Padding(
                                                                padding: EdgeInsets.only(top: 35.h, bottom: 35.h),
                                                                child: CustomWidgets.text(
                                                                  "This Event Data Not Found",
                                                                  fontSize: 14.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: CustomColor.btnSelect,
                                                                ),
                                                              )
                                                        : activity.bookingDetail!.bookedService!.serviceName == "Studio Wallet"
                                                            ? Column(
                                                                children: [
                                                                  CustomWidgets.text(
                                                                    activity.bookingDetail!.bookedService!.serviceName.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    fontSize: 15.sp,
                                                                    color: CustomColor.btn,
                                                                    fontWeight: FontWeight.w800,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 1.h,
                                                                  ),
                                                                  CustomWidgets.text(
                                                                    activity.title.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    fontSize: 13.sp,
                                                                    color: CustomColor.btn,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 6.h,
                                                                  ),
                                                                  Container(
                                                                    height: 70.h,
                                                                    // alignment: Alignment.center,
                                                                    padding: const EdgeInsets.all(10),
                                                                    child: Table(
                                                                      border: TableBorder.all(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: Colors.grey.shade300,
                                                                      ),
                                                                      children: [
                                                                        TableRow(
                                                                          children: [
                                                                            /// STUDIO NAME
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  "Package Name",
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                  fontWeight: FontWeight.w900,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  activity.bookingDetail!.bookedService!.service!.packageDetail![0]
                                                                                      .packageName
                                                                                      .toString(),
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        /// reg date
                                                                        TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  "Registration Date",
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                  fontWeight: FontWeight.w900,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  dateData,
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        ///Price Hourly
                                                                        TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  "Price Hourly",
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                  fontWeight: FontWeight.w900,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  "${activity.bookingDetail!.bookedService!.service!.priceHourly.toString()}",
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            //
                                                                          ],
                                                                        ),

                                                                        ///package_hour
                                                                        TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  "Package Hour",
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                  fontWeight: FontWeight.w900,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  activity.bookingDetail!.bookedService!.service!.packageDetail![0]
                                                                                      .packageHour
                                                                                      .toString(),
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            //
                                                                          ],
                                                                        ),

                                                                        ///package_rate
                                                                        TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  "Package Rate",
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                  fontWeight: FontWeight.w900,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  activity.bookingDetail!.bookedService!.service!.packageDetail![0]
                                                                                      .packageRate
                                                                                      .toString(),
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            //
                                                                          ],
                                                                        ),

                                                                        ///discount
                                                                        TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  "Discount",
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                  fontWeight: FontWeight.w900,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                child: activity.bookingDetail!.bookByTeacher == true
                                                                                    ? CustomWidgets.text(
                                                                                        "50%",
                                                                                        textAlign: TextAlign.start,
                                                                                        fontSize: 11.sp,
                                                                                      )
                                                                                    : CustomWidgets.text(
                                                                                        "0%",
                                                                                        textAlign: TextAlign.start,
                                                                                        fontSize: 11.sp,
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                            //
                                                                          ],
                                                                        ),

                                                                        /// payment amount
                                                                        TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                                child: Padding(
                                                                                    padding:
                                                                                        EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                                    child: CustomWidgets.text(
                                                                                      "Payment Amount",
                                                                                      textAlign: TextAlign.start,
                                                                                      fontSize: 11.sp,
                                                                                      fontWeight: FontWeight.w900,
                                                                                    ))),
                                                                            TableCell(
                                                                              child: Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                                child: CustomWidgets.text(
                                                                                  activity.bookingDetail!.payment![0].paymentAmount.toString(),
                                                                                  textAlign: TextAlign.start,
                                                                                  fontSize: 11.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // SizedBox(
                                                                  //   height: 35.h,
                                                                  //   width: double.infinity,
                                                                  // ),
                                                                ],
                                                              )
                                                            : Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                             : CustomWidgets.NoInertnet(bottom: 100),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
