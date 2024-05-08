// ignore_for_file: unnecessary_string_interpolations, unnecessary_null_comparison, prefer_typing_uninitialized_variables, unnecessary_new, unnecessary_brace_in_string_interps, unrelated_type_equality_checks

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../Data/Model/get_all_event_concert_model.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class UpcomingEventDetailsScreen extends StatefulWidget {
  const UpcomingEventDetailsScreen({super.key});

  @override
  State<UpcomingEventDetailsScreen> createState() => _UpcomingEventDetailsScreenState();
}

class _UpcomingEventDetailsScreenState extends State<UpcomingEventDetailsScreen> {
  EventData upcomingEvent = Get.arguments;
  var time;
  var date;
  @override
  void initState() {
    super.initState();
    var newDate = DateFormat("dd/MM/yyyy").parse(upcomingEvent.date.toString());

    date = DateFormat('d MMMM, yyyy').format(DateTime.parse(newDate.toString()));
    if (kDebugMode) {
      print('Time :::::::: ${upcomingEvent.time.toString()}');
    }
    time = upcomingEvent.time.toString();

    var temp = int.parse(time.split(':')[0]);
    String? t;
    if (temp >= 12 && temp < 24) {
      t = " PM";
    } else {
      t = " AM";
    }
    if (temp > 12) {
      temp = temp - 12;
      if (temp < 10) {
        time = time.replaceRange(0, 2, "0$temp");
        time += t;
      } else {
        time = time.replaceRange(0, 2, "$temp");
        time += t;
      }
    } else if (temp == 00) {
      time = time.replaceRange(0, 2, '12');
      time += t;
    } else {
      time += t;
    }

    if (kDebugMode) {
      print('Time :::::::: $time');
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
              Image.asset(
                backgroundImage,
              ),
              Obx(
                () {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomWidgets.CustAppbar(title: 'Event & Concert'),
                      // no internet connection
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
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 35.h,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          child: (upcomingEvent.file != null)
                                              ? CustomWidgets.customImage(fit: BoxFit.fill, image: upcomingEvent.file!)
                                              : CustomWidgets.NoImage(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          physics: const BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              //event name
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    eventname,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text('${upcomingEvent.name}',
                                                        softWrap: true, fontSize: 13.sp, fontWeight: FontWeight.w800),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //artist name
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    eventartist,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text(
                                                      upcomingEvent.artist == "" || upcomingEvent.artist == null
                                                          ? "  -  "
                                                          : '${upcomingEvent.artist}',
                                                      softWrap: true,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //event date
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    eventdate,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text(
                                                      upcomingEvent.date != null ? '${date}' : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //doors Open
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    entryTime,
                                                    scale: 6,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        CustomWidgets.text(upcomingEvent.entryTime != null ? "Doors Open: " : '  -  ',
                                                            softWrap: true, fontWeight: FontWeight.w800),
                                                        CustomWidgets.text(
                                                          upcomingEvent.entryTime != null ? "${upcomingEvent.entryTime.toString()}" : '  -  ',
                                                          softWrap: true,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //event time
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    eventtime,
                                                    scale: 2.8,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  /* Expanded(
                                                    child: CustomWidgets.text(
                                                      upcomingEvent.time != null
                                                          ? '${time.toString()}'
                                                          : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  )*/
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        CustomWidgets.text(upcomingEvent.time != null ? "Event Starts: " : '  -  ',
                                                            softWrap: true, fontWeight: FontWeight.w800),
                                                        CustomWidgets.text(
                                                          upcomingEvent.time != null ? "${upcomingEvent.time.toString()}" : '  -  ',
                                                          softWrap: true,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //event address
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    address,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text(
                                                      upcomingEvent.venue != null ? '${upcomingEvent.venue}' : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //ticket price
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    eventtic,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text(
                                                      (upcomingEvent.ticketType == "free" || upcomingEvent.ticketPrice.toString() == null)
                                                          ? 'free  '
                                                          : '${upcomingEvent.ticketPrice} AED per ticket ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              //event discription
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    desc,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text(
                                                      upcomingEvent.desc != null ? '${upcomingEvent.desc}' : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : CustomWidgets.NoInertnet(top: 120),
                      SizedBox(
                        height: 3.h,
                      ),
                      isInternetAvailable.value == true
                          ? Column(
                              children: [
                                upcomingEvent.remainingTicket != 0
                                    //event ragister
                                    ? CustomButton(
                                        width: 90.w,
                                        bordercolor: CustomColor.btnUnselect,
                                        color: CustomColor.btn,
                                        onPressed: () async {
                                          //ticker alert
                                          final result = await ticketAlert(context: context, eventId: upcomingEvent.sId!);

                                          if (result != null) {
                                            welcomeController.eventsDataApi(isLoaderShow: false);
                                            if (kDebugMode) {
                                              print('Event returned: $result');
                                            }
                                          }
                                          if (kDebugMode) {
                                            print(LoginSuccessModel.fromJson(
                                              GetStorage().read(
                                                userData,
                                              ),
                                            ).data!.sId.toString());
                                            print(upcomingEvent.sId!);
                                          }
                                        },
                                        text: 'Register',
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: CustomWidgets.text(
                                          "Apologies for the inconvenience, but the tickets are currently unavailable.",
                                          color: CustomColor.btn,
                                          fontSize: 12.5.sp,
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                        ),
                                      )
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

// ticker alert
  ticketAlert({
    required BuildContext context,
    required String eventId,
  }) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            GestureDetector(
              onTap: () {
                bookingController.agree.value = false;
                //T & C alert
                TermsConditionAlert(
                    onPressed: () {
                      bookingController.agree.value = false;
                      Get.back(closeOverlays: true);
                      Get.back(closeOverlays: true);

                      paymentController.eventPaymentInfokAPI(
                          userId: LoginSuccessModel.fromJson(
                            GetStorage().read(
                              userData,
                            ),
                          ).data!.sId.toString(),
                          eventId: eventId,
                          quantity: welcomeController.ticketCount.value);

                      /*     applePaymentSheet(context, amount: payment, onTapPaytabs: () {
                        bookingController.eventTicBookAPI(
                            payment: payment,
                            UserId: LoginSuccessModel.fromJson(
                              GetStorage().read(
                                userData,
                              ),
                            ).data!.sId.toString(),
                            eventId: eventId,
                            quantity: welcomeController.ticketCount.value);
                      }, onPressedApple: () {}); */
                    },
                    context: context,
                    text: "${upcomingEvent.terms}");
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
                  "Book",
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
                      "Your Tickets",
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        bookingController.agree.value = false;
                        welcomeController.ticketCount.value = 1;
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
                    left: 40,
                    right: 40,
                  ),
                  child: Obx(() {
                    return Container(
                      height: 8.h,
                      decoration: BoxDecoration(
                          color: CustomColor.bgBottem,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: CustomColor.btnSelectDateBorder)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // ticket Decrement
                          GestureDetector(
                              onTap: () {
                                welcomeController.ticketDecrement();
                              },
                              child: welcomeController.isCounter != true
                                  ? const CircleAvatar(
                                      backgroundColor: CustomColor.btn,
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ))
                                  : const Icon(
                                      Icons.remove,
                                      color: CustomColor.btn,
                                    )),
                          CustomWidgets.text(
                            "${welcomeController.ticketCount}",
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                          //ticket increment
                          GestureDetector(
                              onTap: () {
                                welcomeController.ticketIncrement();
                              },
                              child: welcomeController.isCounter == true
                                  ? const CircleAvatar(
                                      backgroundColor: CustomColor.btn,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ))
                                  : const Icon(
                                      Icons.add,
                                      color: CustomColor.btn,
                                    )),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
