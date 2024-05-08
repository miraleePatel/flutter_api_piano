// ignore_for_file: implementation_imports, unused_import, unnecessary_import, unnecessary_string_interpolations, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../Controller/activity_controller.dart';
import '../../../Data/Model/login_response_model.dart';
import '../../../Utils/app_color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ActivityController activityController = Get.put(ActivityController());

  @override
  void initState() {
    activityController.activityDataApi(
        userId: LoginSuccessModel.fromJson(
      GetStorage().read(
        userData,
      ),
    ).data!.sId.toString());
    
    super.initState();
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
                children: [
                  CustomWidgets.CustAppbar(title: "Notification"),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(
                        () {
                          return isInternetAvailable.value == true
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 2.4.h,
                                    ),
                                    activityController.filterNotificationList.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            reverse: true,
                                            itemCount: activityController.filterNotificationList.length,
                                            physics: const BouncingScrollPhysics(),
                                            padding: EdgeInsets.only(
                                              left: 5.w,
                                              right: 5.w,
                                              top: 0.h,
                                              bottom: 4.h,
                                            ),
                                            itemBuilder: (context, index) {
                                              DateTime utcDateTime =
                                                  DateTime.parse(activityController.filterNotificationList[index].dateTime.toString());
                                              DateTime localDateTime = utcDateTime.toLocal();
                                              String formattedDateTime = DateFormat('d MMM, yyyy').format(localDateTime);

                                              return CustomWidgets.customContainer(
                                                margintop: 2.h,
                                                height: 8.h,
                                                top: 2.h,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 5.h,
                                                      width: 78.w,
                                                      margin: EdgeInsets.only(
                                                        left: 4.w,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          CustomWidgets.text(
                                                            '${activityController.filterNotificationList[index].title.toString()}',
                                                            fontSize: 12.sp,
                                                            softWrap: false,
                                                            maxLine: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            fontWeight: FontWeight.w800,
                                                          ),
                                                          CustomWidgets.text(
                                                            formattedDateTime,
                                                            fontSize: 10.sp,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(top: 300),
                                            child: Center(
                                              child: CustomWidgets.text('No Notification Found', fontSize: 13.sp),
                                            ),
                                          ),
                                  ],
                                )
                                : CustomWidgets.NoInertnet(top: 200);
                        },
                      ),
                    ),
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
