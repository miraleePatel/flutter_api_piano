// ignore_for_file: prefer_collection_literals, avoid_print, prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, unused_local_variable, sort_child_properties_last, unnecessary_null_comparison, unnecessary_string_escapes, non_constant_identifier_names
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:piano_project/Controller/booking_controller.dart';
import 'package:piano_project/Controller/payment_controller.dart';
import 'package:piano_project/Utils/constant_widgets.dart';
import 'package:piano_project/Widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';
import 'package:time_range/time_range.dart';
import '../../../../Controller/welcome_controller.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Data/Model/time_available_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String id = Get.arguments[0];
  var timelist = Get.arguments[1];
  var date = Get.arguments[2];
  var screenname = Get.arguments[3];
  var plan = Get.arguments[4];
  var terms;

  BookingController bookingController = Get.put(BookingController());
  PaymentController paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    bookingController.timeList = timelist;
    termsget();
    welcomeController.getAllConcertCategoryApi();
  }

  @override
  void dispose() {
    super.dispose();
    bookingController.timeRange = null;
  }

  //get terms & condition
  termsget() {
    for (int i = 0; i < welcomeController.studioRentalList.length; i++) {
      if (id == welcomeController.studioRentalList[i].sId) {
        terms = welcomeController.studioRentalList[i].terms;
      }
    }
  }

  // int convertTimeToInt(TimeOfDay time) {
  //   return time.hour * 60 + time.minute;
  // }

  @override
  Widget build(BuildContext context) {
    bookingController.listget(timelist: timelist);
    return Container(
      color: Colors.black.withOpacity(
        0.1,
      ),
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
                    ? bookingController.availablTimeList.isNotEmpty
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  CustomWidgets.text(
                                    'Schedule',
                                    fontSize: 14.sp,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),

                                  // 10 hour
                                  (screenname == "studioscreen" && plan == '10hour' && bookingController.remainingHour.value != 0)
                                      ? Obx(() => Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: CustomWidgets().buildRichText(
                                                    text1: bookingController.remainingHour.value > 1 ? "Remaining Hours : " : "Remaining Hour : ",
                                                    text2: bookingController.remainingHour.value.toString())),
                                          ))
                                      : Container(),
                                  (screenname == "studioscreen" && plan == '10hour' && bookingController.remainingHour.value != 0)
                                      ? SizedBox(
                                          height: 2.h,
                                        )
                                      : Container(),

                                  // 25 hour
                                  (screenname == "studioscreen" && plan == '25hour' && bookingController.remaining25Hour.value != 0)
                                      ? Obx(() => Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: CustomWidgets().buildRichText(
                                                    text1: bookingController.remaining25Hour.value > 1 ? "Remaining Hours : " : "Remaining Hour : ",
                                                    text2: bookingController.remaining25Hour.value.toString())),
                                          ))
                                      : Container(),
                                  (screenname == "studioscreen" && plan == '25hour' && bookingController.remaining25Hour.value != 0)
                                      ? SizedBox(
                                          height: 2.h,
                                        )
                                      : Container(),

                                  // 50 hour
                                  (screenname == "studioscreen" && plan == '50hour' && bookingController.remaining50Hour.value != 0)
                                      ? Obx(() => Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: CustomWidgets().buildRichText(
                                                    text1: bookingController.remaining50Hour.value > 1 ? "Remaining Hours : " : "Remaining Hour : ",
                                                    text2: bookingController.remaining50Hour.value.toString())),
                                          ))
                                      : Container(),
                                  (screenname == "studioscreen" && plan == '50hour' && bookingController.remaining50Hour.value != 0)
                                      ? SizedBox(
                                          height: 2.h,
                                        )
                                      : Container(),

                                  Padding(
                                    padding: EdgeInsets.only(left: 4.w),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: CustomWidgets.text("Available Time :",
                                          color: CustomColor.btn, fontWeight: FontWeight.w800, fontSize: 13.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  //refreshing time slot
                                  RefreshIndicator(
                                    color: CustomColor.btn,
                                    onRefresh: () async {
                                      //studio rental
                                      if (screenname == "studioscreen") {
                                        await bookingController.studiotimeAvalibaleApi(plan: "", id: id, selectdate: date);
                                        setState(() {});
                                        bookingController.list = timelist;
                                        log(timelist.toString());
                                      }
                                      //concert hall
                                      else {
                                        await bookingController.timeAvalibaleApi(id: id, selectdate: date);
                                      }
                                      setState(() {});
                                      timelist = bookingController.timeAvailableModel.value.data!;
                                      bookingController.listget(timelist: timelist);
                                    },
                                    //showing time slot
                                    child: GridView.builder(
                                        padding: EdgeInsets.only(left: 4.w, right: 4.w),
                                        itemCount: bookingController.availablTimeList.length,
                                        shrinkWrap: true,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 5.h,
                                          mainAxisSpacing: 2.h,
                                          crossAxisSpacing: 2.w,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                              color: CustomColor.cld1,
                                              border: Border.all(color: CustomColor.cldBorder, width: 1),
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    "${bookingController.availablTimeList[index]}",
                                                    style: TextStyle(fontSize: 12.sp, color: CustomColor.btn),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  //Time range
                                  TimeRange(
                                    fromTitle:
                                        CustomWidgets.text('Start Time : ', color: CustomColor.btn, fontWeight: FontWeight.w800, fontSize: 13.sp),
                                    toTitle: CustomWidgets.text('End Time : ', color: CustomColor.btn, fontWeight: FontWeight.w800, fontSize: 13.sp),
                                    titlePadding: 5.w,
                                    textStyle: const TextStyle(
                                      color: CustomColor.white,
                                      fontFamily: 'minion-pro-cufonfonts',
                                    ),
                                    activeTextStyle: const TextStyle(
                                      color: CustomColor.white,
                                      fontFamily: 'minion-pro-cufonfonts',
                                    ),
                                    borderColor: Colors.black,
                                    alwaysUse24HourFormat: true,
                                    activeBorderColor: CustomColor.btnSelect,
                                    backgroundColor: Colors.black,
                                    activeBackgroundColor: CustomColor.btnSelect,
                                    firstTime: TimeOfDay(hour: 9, minute: 00),
                                    lastTime: const TimeOfDay(hour: 20, minute: 00),
                                    initialRange: bookingController.timeRange,
                                    timeStep: 60,
                                    timeBlock: 60,
                                    onRangeCompleted: (range) {
                                      if (range != null) {
                                        final step = Duration(minutes: 60);
                                        bookingController.totalHours.value = bookingController
                                            .getTimes(range.start, range.end, step)
                                            .map((tod) => tod.toString().replaceAll('TimeOfDay(', '').replaceAll(')', ''))
                                            .toList();
                                        bookingController.totalHours.removeLast();
                                      }

                                      return setState(() {
                                        bookingController.timeRange = range;
                                      });
                                    },
                                  ),

                                  SizedBox(height: 2.h),
                                  //open to close time
                                  SizedBox(
                                    width: 90.w,
                                    child: CustomWidgets().buildRichText(fontSize1: 12.sp, text1: 'Venue Timings :  ', text2: "09 : 00 to 20 : 00"),
                                  ),

                                  SizedBox(height: 1.h),
                                  //selected time slot
                                  if (bookingController.timeRange != null)
                                    SizedBox(
                                      width: 90.w,
                                      child: CustomWidgets().buildRichText(
                                          fontSize1: 12.sp,
                                          text1: 'Selected Time Slot :  ',
                                          text2:
                                              '${bookingController.timeRange!.start.toString().replaceAll('TimeOfDay(', '').replaceAll(')', '')}  to  ${bookingController.timeRange!.end.toString().replaceAll('TimeOfDay(', '').replaceAll(')', '')}'),
                                    ),

                                  SizedBox(height: 1.h),
                                  // total selected hour
                                  if (bookingController.timeRange != null)
                                    SizedBox(
                                      width: 90.w,
                                      child: CustomWidgets().buildRichText(
                                          fontSize1: 12.sp, text1: 'Total Hour :  ', text2: '${bookingController.totalHours.length} Hour'),
                                    ),
                                  SizedBox(height: 2.h),

                                  // pay now
                                  CustomButton(
                                    width: 90.w,
                                    onPressed: () {
                                      bookingController.agree.value = false;
                                      if (bookingController.timeRange != null) {
                                        //selected hour in add selectTimeList
                                        final step = Duration(minutes: 60);
                                        bookingController.selectTimeList = bookingController
                                            .getTimes(bookingController.timeRange!.start, bookingController.timeRange!.end, step)
                                            .map((tod) => tod.toString().replaceAll('TimeOfDay(', '').replaceAll(')', ''))
                                            .toList();
                                        log('bookingController.selectTimeList ================================>  ${bookingController.selectTimeList}');
                                        bookingController.selectTimeList.removeLast();
                                        log('bookingController.selectTimeList removeLast================================>  ${bookingController.selectTimeList}');

                                        /// studioscreen payment

                                        if (screenname == "studioscreen") {
                                          print('studio rental screen');

                                          if (bookingController.listContainsAll(timelist, bookingController.selectTimeList) == true) {
                                            TermsConditionAlert(
                                                onPressed: () {
                                                  Get.back(closeOverlays: true);
                                                  paymentController.studioPaymentInfokAPI(
                                                    studioID: id,
                                                    date: date,
                                                    plan: plan,
                                                    timeslot: bookingController.selectTimeList,
                                                    userId: LoginSuccessModel.fromJson(
                                                      GetStorage().read(
                                                        userData,
                                                      ),
                                                    ).data!.sId.toString(),
                                                  );

                                                  Get.toNamed(Routes.STUDIO_PAYMENT_INFO_SCREEN,
                                                      arguments: [id, date, plan, bookingController.selectTimeList]);
                                                },
                                                context: context,
                                                text: "${terms}");
                                          } else {
                                            informationSnackBar(message: "Please Select Available Time slots");
                                          }
                                        }

                                        /// Concert hall rental screen  payment

                                        else {
                                          print('ID :::::::::::::::: ${id.toString()}');

                                          for (int i = 0; i <= welcomeController.getAllConcertCategory1.value.data!.length - 1; i++) {
                                            if (welcomeController.getAllConcertCategory1.value.data![i].sId == id.toString()) {
                                              print('SID ::::::: ${welcomeController.getAllConcertCategory1.value.data![i].sId}');

                                              if (welcomeController.getAllConcertCategory1.value.data![i].sId == "645e03019c980d2782388ae2") {
                                                /// Private event  payment
                                                if (bookingController.selectTimeList.length >= 4) {
                                                  if (bookingController.listContainsAll(timelist, bookingController.selectTimeList) == true) {
                                                    ///  T&C alert
                                                    TermsConditionAlert(
                                                        onPressed: () {
                                                          bookingController.agree.value = false;
                                                          Get.back(closeOverlays: true);
                                                          paymentController.concertPaymentInfokAPI(
                                                            plan: "hourly",
                                                            concertID: id.toString(),
                                                            userId: LoginSuccessModel.fromJson(
                                                              GetStorage().read(
                                                                userData,
                                                              ),
                                                            ).data!.sId.toString(),
                                                            date: date,
                                                            timeslot: bookingController.selectTimeList,
                                                          );
                                                          Get.toNamed(Routes.CONCERT_PAYMENT_INFO_SCREEN,
                                                              arguments: [id, date, bookingController.selectTimeList, false]);
                                                        },
                                                        context: context,
                                                        text: "${welcomeController.getAllConcertCategory1.value.data![i].terms.toString()}");
                                                  } else {
                                                    informationSnackBar(message: "Please Select Available Time slots");
                                                  }
                                                } else {
                                                  informationSnackBar(
                                                    message: "Please Select Minimum 4 hours",
                                                  );
                                                }
                                              } else if (welcomeController.getAllConcertCategory1.value.data![i].sId == "641a7a909c55f514f6cbf316") {
                                                // Student recital payment
                                                if (bookingController.selectTimeList.length >= 2) {
                                                  print("dfgv..........................");
                                                  print(timelist.toString());
                                                  print(bookingController.selectTimeList.length);

                                                  if (bookingController.listContainsAll(timelist, bookingController.selectTimeList) == true) {
                                                    ///  T&C alert
                                                    TermsConditionAlert(
                                                        onPressed: () {
                                                          bookingController.agree.value = false;
                                                          Get.back(closeOverlays: true);
                                                          informationAlert(
                                                            id: id.toString(),
                                                            context: context,
                                                            concertId: id,
                                                            date: date,
                                                            timeslot: bookingController.selectTimeList,
                                                            userId: LoginSuccessModel.fromJson(
                                                              GetStorage().read(
                                                                userData,
                                                              ),
                                                            ).data!.sId.toString(),
                                                          );
                                                        },
                                                        context: context,
                                                        text: "${welcomeController.getAllConcertCategory1.value.data![i].terms.toString()}");
                                                    // "${welcomeController.getAllConcertCategory1.value.data![0].terms.toString()}");
                                                  } else {
                                                    informationSnackBar(message: "Please Select Available Time slots");
                                                  }
                                                } else {
                                                  informationSnackBar(
                                                    message: "Please Select Minimum 2 hours ",
                                                  );
                                                }
                                              } else {
                                                //  ************************** Recording payment
                                                if (bookingController.listContainsAll(timelist, bookingController.selectTimeList) == true) {
                                                  // bookingController.selectTimeList
                                                  //     .removeLast();

                                                  ///  T&C alert
                                                  TermsConditionAlert(
                                                      onPressed: () {
                                                        bookingController.agree.value = false;
                                                        Get.back(closeOverlays: true);
                                                        paymentController.concertPaymentInfokAPI(
                                                          concertID: id.toString(),
                                                          plan: "hourly",
                                                          userId: LoginSuccessModel.fromJson(
                                                            GetStorage().read(
                                                              userData,
                                                            ),
                                                          ).data!.sId.toString(),
                                                          date: date,
                                                          timeslot: bookingController.selectTimeList,
                                                        );
                                                        Get.toNamed(Routes.CONCERT_PAYMENT_INFO_SCREEN,
                                                            arguments: [id, date, bookingController.selectTimeList, false]);
                                                      },
                                                      context: context,
                                                      text: "${welcomeController.getAllConcertCategory1.value.data![i].terms.toString()}");
                                                } else {
                                                  informationSnackBar(message: "Please select available time slots");
                                                }
                                              }
                                            }
                                          }
                                        }
                                      } else {
                                        informationSnackBar(
                                          message: "Please select time slots ",
                                        );
                                      }
                                    },
                                    text: 'Pay Now',
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: CustomWidgets.text('Available time slots are already booked..', fontSize: 11.sp),
                            ),
                          )
                    : CustomWidgets.NoInertnet(top: 200);
              }),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  informationAlert({
    required BuildContext context,
    void Function()? onPressed,
    required String userId,
    required String concertId,
    required List timeslot,
    required String date,
    required String id,
  }) {
    stutesbar();
    final GlobalKey<FormState> informationkey = GlobalKey();
    welcomeController.schoolnameController.clear();
    welcomeController.teachernameController.clear();
    welcomeController.performersController.clear();
    welcomeController.guestsController.clear();
    showDialog(
        context: context,
        builder: (BuildContext context1) {
          return Form(
            key: informationkey,
            child: AlertDialog(
              scrollable: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              actionsPadding: EdgeInsets.zero,
              actions: [
                InkWell(
                  onTap: () {
                    if (informationkey.currentState!.validate()) {
                      Get.back();

                      paymentController.concertPaymentInfokAPI(
                        concertID: concertId,
                        userId: userId,
                        date: date,
                        plan: "hourly",
                        timeslot: timeslot,
                      );
                      Get.toNamed(Routes.CONCERT_PAYMENT_INFO_SCREEN, arguments: [id, date, bookingController.selectTimeList, true]);
                    }
                  },
                  child: Container(
                    height: 5.h,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: CustomColor.btn,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    child: CustomWidgets.text(
                      "Submit",
                      fontWeight: FontWeight.w600,
                      color: CustomColor.white,
                    ),
                  ),
                ),
              ],
              contentPadding: EdgeInsets.only(
                top: 2.h,
              ),
              content: SizedBox(
                width: 150.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CustomWidgets.text(
                          "Information Panel",
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        InkWell(
                          child: const Icon(Icons.close),
                          onTap: () {
                            welcomeController.schoolnameController.clear();
                            welcomeController.teachernameController.clear();
                            welcomeController.performersController.clear();
                            welcomeController.guestsController.clear();
                            Get.back(closeOverlays: true);
                          },
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: CustomEnquiryTextFiled(
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.trim() == null || value.trim().isEmpty) {
                            welcomeController.schoolnameController.clear();
                            return "Please add school name";
                          } else {
                            return null;
                          }
                        },
                        controller: welcomeController.schoolnameController,
                        hintText: 'School Name',
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: CustomEnquiryTextFiled(
                            controller: welcomeController.teachernameController,
                            keyboardType: TextInputType.text,
                            hintText: 'Teacher Name',
                            validator: (String? value) {
                              if (value!.trim() == null || value.trim().isEmpty) {
                                welcomeController.teachernameController.clear();
                                return "Please add teacher name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: CustomEnquiryTextFiled(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[' '\+\0-9\.]")),
                            ],
                            controller: welcomeController.performersController,
                            hintText: 'Performers No',
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value!.trim() == null || value.trim().isEmpty) {
                                welcomeController.performersController.clear();
                                return "Please add Performers No";
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: CustomEnquiryTextFiled(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[' '\+\0-9\.]")),
                        ],
                        controller: welcomeController.guestsController,
                        hintText: 'No Of Guests ',
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.trim() == null || value.trim().isEmpty) {
                            welcomeController.guestsController.clear();
                            return "Please add No Of Guests";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '90.0',
    status: PaymentItemStatus.final_price,
  )
];
ApplePaymentSheet(BuildContext context, {required Function() onTapPaytabs}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.btnBCon,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 220,
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
                      "What choose for Payment?",
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                    Spacer(),
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        Get.back(closeOverlays: true);
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onTapPaytabs,
                child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(color: CustomColor.paytabsBtn, borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          paytabsImage,
                          scale: 7,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomWidgets.text(
                          "Paytabs",
                          fontWeight: FontWeight.w800,
                          fontSize: 18.sp,
                        ),
                      ],
                    )),
              ),
              ApplePayButton(
                // ignore: deprecated_member_use
                paymentConfigurationAsset: 'applepay.json',
                paymentItems: _paymentItems,
                style: ApplePayButtonStyle.black,

                type: ApplePayButtonType.plain,
                width: 300,
                height: 50,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (Map<String, dynamic> value) {
                  print("Response type: ${value.runtimeType}");
                  print("Response --------------->");
                  print(value);
                  print("----------------------------------------------\n");
                  Get.back(closeOverlays: true);
                  Get.back(closeOverlays: true);
                },
                onError: (error) {
                  print("error --------------->");
                  print(error);
                },

                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      });
}
