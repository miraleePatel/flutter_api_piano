import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../Data/Model/get_activity_model.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/string_constants.dart';
import '../../../Widget/custom_widget.dart';

class EnquireActivityDetailsScreen extends StatefulWidget {
  const EnquireActivityDetailsScreen({super.key});

  @override
  State<EnquireActivityDetailsScreen> createState() => _EnquireActivityDetailsScreenState();
}

class _EnquireActivityDetailsScreenState extends State<EnquireActivityDetailsScreen> {
  Activity activity = Get.arguments[0];
  var dateData = Get.arguments[1];
  String formatDate(String inputDate) {
    final parsedDate = DateFormat('dd/MM/yyyy').parse(inputDate);
    final formattedDate = DateFormat('dd MMM, yyyy', 'en_US').format(parsedDate);
    return formattedDate;
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomWidgets.CustAppbar(
                    title: "My Activity",
                  ),
                  // No internet connection
                  Obx(() {return isInternetAvailable.value == true
                      ? activity.enquiryDetail != null
                          ? Expanded(
                              child: CustomWidgets.customContainer(
                              margintop: 2.h,
                              top: 5.5.h,
                              // height: 45.h,
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 1.h,
                                  bottom: 2.h,
                                ),
                                child: Column(
                                  children: [
                                    /// title
                                    CustomWidgets.text(
                                      activity.enquiryDetail!.serviceName.toString(),
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

                                    /// table

                                    // piano rental enqury activity
                                    activity.enquiryDetail!.serviceName == "Piano Rental"
                                        ? Column(
                                            children: [
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
                                                        /// Piano NAME
                                                        TableCell(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                            child: CustomWidgets.text(
                                                              "Service Name",
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
                                                              activity.enquiryDetail!.serviceName.toString(),
                                                              textAlign: TextAlign.start,
                                                              fontSize: 11.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    /// Service Type
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                            child: CustomWidgets.text(
                                                              "Service Type",
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
                                                              activity.enquiryDetail!.serviceType.toString(),
                                                              textAlign: TextAlign.start,
                                                              fontSize: 11.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    /// Service Type
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                            child: CustomWidgets.text(
                                                              "Piano Type",
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
                                                              activity.enquiryDetail!.pianoService!.pianoType != ""
                                                                  ? activity.enquiryDetail!.pianoService!.pianoType.toString()
                                                                  : "-",
                                                              textAlign: TextAlign.start,
                                                              fontSize: 11.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    /// date
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

                                                    /// Enquiry date
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                            child: CustomWidgets.text(
                                                              "Enquiry Date",
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
                                                              formatDate(
                                                                activity.enquiryDetail!.date.toString(),
                                                              ),
                                                              textAlign: TextAlign.start,
                                                              fontSize: 11.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                            child: CustomWidgets.text(
                                                              "Location",
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
                                                              activity.enquiryDetail!.location.toString(),
                                                              textAlign: TextAlign.start,
                                                              fontSize: 11.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                            child: CustomWidgets.text(
                                                              "Note",
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
                                                              activity.enquiryDetail!.note.toString(),
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
                                        // piano Service enqury activity
                                        : activity.enquiryDetail!.serviceName == "Piano Service"
                                            ? Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
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
                                                                /// Service Name
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Service Name",
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
                                                                      activity.enquiryDetail!.serviceName.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            /// Service Type
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Service Type",
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
                                                                      activity.enquiryDetail!.serviceType.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            //  "Piano Type"
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Piano Type",
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
                                                                      activity.enquiryDetail!.pianoService!.pianoType.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Piano Brand",
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
                                                                      activity.enquiryDetail!.pianoService!.pianoBrand.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            /// date
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

                                                            /// Enquiry date
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Enquiry Date",
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
                                                                      formatDate(
                                                                        activity.enquiryDetail!.date.toString(),
                                                                      ),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Location",
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
                                                                      activity.enquiryDetail!.location.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            // note
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Note",
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
                                                                      activity.enquiryDetail!.note.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            // note
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            // Find piano Teacher enqury activity
                                            : activity.enquiryDetail!.serviceName == "Piano Teacher"
                                                ? Column(
                                                    children: [
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
                                                                /// Piano NAME
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Service Name",
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
                                                                      activity.enquiryDetail!.serviceName.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            /// Brand
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Brand",
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
                                                                      activity.enquiryDetail!.serviceType.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            /// Registration date
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

                                                            /// Enquiry date
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Enquiry Date",
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
                                                                      formatDate(
                                                                        activity.enquiryDetail!.date.toString(),
                                                                      ),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Location",
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
                                                                      activity.enquiryDetail!.location.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            // note
                                                            TableRow(
                                                              children: [
                                                                TableCell(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                    child: CustomWidgets.text(
                                                                      "Note",
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
                                                                      activity.enquiryDetail!.note.toString(),
                                                                      textAlign: TextAlign.start,
                                                                      fontSize: 11.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            // note
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container()
                                  ],
                                ),
                              ),
                            ))
                          : Padding(
                              padding: EdgeInsets.only(top: 35.h, bottom: 35.h),
                              child: CustomWidgets.text(
                                "This Enquiry Data Not Found",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: CustomColor.btnSelect,
                              ),
                            )
                      :CustomWidgets.NoInertnet(bottom: 100);}),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
