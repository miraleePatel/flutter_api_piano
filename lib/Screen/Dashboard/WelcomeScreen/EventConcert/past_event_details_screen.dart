// ignore_for_file: unnecessary_string_interpolations, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../Data/Model/get_all_event_concert_model.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class PastEventDetailsScreen extends StatefulWidget {
  const PastEventDetailsScreen({super.key});

  @override
  State<PastEventDetailsScreen> createState() => _PastEventDetailsScreenState();
}

class _PastEventDetailsScreenState extends State<PastEventDetailsScreen> {
  EventData pastEvent = Get.arguments;
  var time;
  var date;
  @override
  void initState() {
    super.initState();
    var newDate = DateFormat("dd/MM/yyyy").parse(pastEvent.date.toString());

    date = DateFormat('d MMMM, yyyy').format(DateTime.parse(newDate.toString()));

    time = pastEvent.time.toString();

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
                      CustomWidgets.CustAppbar(title: 'Past Events'),
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
                                          child: (pastEvent.file != null)
                                              ? CustomWidgets.customImage(fit: BoxFit.fill, image: pastEvent.file!)
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
                                                height: 3.h,
                                              ),
                                              //event name
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    eventname,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text('${pastEvent.name}',
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
                                                      (pastEvent.artist == "" || pastEvent.artist == null)
                                                          ? '  -  '
                                                          : '${pastEvent.artist.toString()}',
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
                                                      pastEvent.date != null ? '${date}' : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //event open
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
                                                        CustomWidgets.text(pastEvent.entryTime != null ? "Doors Open: " : '  -  ',
                                                            softWrap: true, fontWeight: FontWeight.w800),
                                                        CustomWidgets.text(
                                                          pastEvent.entryTime != null ? "${pastEvent.entryTime.toString()}" : '  -  ',
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
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        CustomWidgets.text(pastEvent.time != null ? "Event Starts: " : '  -  ',
                                                            softWrap: true, fontWeight: FontWeight.w800),
                                                        CustomWidgets.text(
                                                          pastEvent.time != null ? "${pastEvent.time.toString()}" : '  -  ',
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
                                                      pastEvent.venue != null ? '${pastEvent.venue}' : '  -  ',
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
                                                      (pastEvent.ticketPrice != null) ? '${pastEvent.ticketPrice} AED per ticket' : 'free  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
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
                                                      pastEvent.desc != null ? pastEvent.desc.toString() : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
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
}
