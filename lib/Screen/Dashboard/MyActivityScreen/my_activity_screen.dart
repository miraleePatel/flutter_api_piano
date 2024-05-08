import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:sizer/sizer.dart';
import '../../../Controller/activity_controller.dart';
import '../../../Controller/authetication_controller.dart';
import '../../../Data/Model/login_response_model.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/constant_widgets.dart';
import '../../../Utils/string_constants.dart';
import '../../../Widget/custom_widget.dart';

class MyActivityScreen extends StatefulWidget {
  const MyActivityScreen({Key? key}) : super(key: key);

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> {
  ActivityController activityController = Get.put(ActivityController());
  AuthController authController = Get.put(AuthController());
  bool isCheck = getVerifyStatus();

  @override
  void initState() {
    getActivity();
    super.initState();
  }

  getActivity() {
    // ignore: unrelated_type_equality_checks
    if (authController.isLogin == true) {
      activityController.activityDataApi(
          userId: LoginSuccessModel.fromJson(
        GetStorage().read(
          userData,
        ),
      ).data!.sId.toString());
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Image.asset(
                  backgroundImage,
                ),
                Obx(
                  // No internet connection
                  () => isInternetAvailable.value == true
                      ? Column(
                          children: [
                            SizedBox(
                              height: 2.4.h,
                            ),
                            Center(
                              child: CustomWidgets.text(
                                "My Activity",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 1.8.h,
                            ),
                            // ignore: unrelated_type_equality_checks
                            authController.isLogin == true
                                ? activityController.activityList.isNotEmpty
                                    ? Column(
                                        children: [
                                          activityController.todayActivityList.isNotEmpty
                                              ? Container(
                                                  height: 3.h,
                                                  width: 13.w,
                                                  margin: EdgeInsets.only(
                                                    right: 78.w,
                                                  ),
                                                  child: CustomWidgets.text(
                                                    "Today",
                                                    textAlign: TextAlign.start,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )
                                              : Container(),
                                          //today activity
                                          activityController.todayActivityList.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  reverse: true,
                                                  itemCount: activityController.todayActivityList.length,
                                                  physics: const BouncingScrollPhysics(),
                                                  padding: EdgeInsets.only(
                                                    left: 5.w,
                                                    right: 5.w,
                                                    top: 0.h,
                                                    bottom: 4.h,
                                                  ),
                                                  itemBuilder: (context, index) {
                                                    // filter date
                                                    DateTime utcDateTime =
                                                        DateTime.parse(activityController.todayActivityList[index].dateTime.toString());
                                                    DateTime localDateTime = utcDateTime.toLocal();
                                                    String formattedDateTime = DateFormat('d MMM, yyyy').format(localDateTime);

                                                    /// filter Time Ago
                                                    final dateTime = DateTime.parse(activityController.todayActivityList[index].dateTime.toString());
                                                    final now1 = DateTime.now();
                                                    var difference = now1.difference(dateTime);

                                                    if (difference.inMinutes <= 1) {
                                                      activityController.timeAgoString.value = 'Just Now';
                                                    }
                                                    if (difference.inMinutes >= 1 && difference.inMinutes <= 60) {
                                                      final minAgo = difference.inMinutes;
                                                      activityController.timeAgoString.value = minAgo == 1 ? '1 minute ago' : '$minAgo minutes ago';
                                                    }
                                                    if (difference.inMinutes > 60) {
                                                      final hoursAgo = difference.inHours;
                                                      activityController.timeAgoString.value = hoursAgo == 1 ? '1 hour ago' : '$hoursAgo hours ago';
                                                    }

                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (activityController.todayActivityList[index].bookingDetail != null) {
                                                          Get.toNamed(Routes.BOOK_ACTIVITY_DETAILS_SCREEN,
                                                              arguments: [activityController.todayActivityList[index], formattedDateTime]);
                                                        } else {
                                                          Get.toNamed(Routes.ENQUIRE_ACTIVITY_DETAILS_SCREEN,
                                                              arguments: [activityController.todayActivityList[index], formattedDateTime]);
                                                        }
                                                      },
                                                      child: CustomWidgets.customContainer(
                                                        margintop: 2.h,
                                                        height: 8.h,
                                                        top: 2.h,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              height: 2.h,
                                                              width: 2.5.w,
                                                              margin: EdgeInsets.only(
                                                                left: 4.w,
                                                              ),
                                                              decoration: const BoxDecoration(
                                                                color: CustomColor.red,
                                                                shape: BoxShape.circle,
                                                              ),
                                                            ),
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
                                                                    activityController.todayActivityList[index].title.toString(),
                                                                    maxLine: 1,
                                                                    softWrap: true,
                                                                    fontSize: 12.sp,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.w800,
                                                                  ),
                                                                  CustomWidgets.text(
                                                                    activityController.timeAgoString.value.toString(),
                                                                    fontSize: 10.sp,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                          activityController.weekActivityList.isNotEmpty
                                              ? Container(
                                                  height: 3.h,
                                                  width: 25.w,
                                                  margin: EdgeInsets.only(
                                                    right: 66.w,
                                                  ),
                                                  child: CustomWidgets.text(
                                                    "This Week",
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )
                                              : Container(),
                                          //weekly activity
                                          activityController.weekActivityList.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  reverse: true,
                                                  itemCount: activityController.weekActivityList.length,
                                                  physics: const BouncingScrollPhysics(),
                                                  padding: EdgeInsets.only(
                                                    left: 5.w,
                                                    right: 5.w,
                                                    top: 1.h,
                                                    bottom: 3.h,
                                                  ),
                                                  itemBuilder: (context, index) {
                                                    DateTime utcDateTime =
                                                        DateTime.parse(activityController.weekActivityList[index].dateTime.toString());
                                                    DateTime localDateTime = utcDateTime.toLocal();
                                                    String formattedDateTime = DateFormat('d MMM, yyyy').format(localDateTime);
                                                    return GestureDetector(
                                                        onTap: () {
                                                          if (activityController.weekActivityList[index].bookingDetail != null) {
                                                            Get.toNamed(Routes.BOOK_ACTIVITY_DETAILS_SCREEN,
                                                                arguments: [activityController.weekActivityList[index], formattedDateTime]);
                                                          } else {
                                                            Get.toNamed(Routes.ENQUIRE_ACTIVITY_DETAILS_SCREEN,
                                                                arguments: [activityController.weekActivityList[index], formattedDateTime]);
                                                          }
                                                        },
                                                        child: CustomWidgets.customContainer(
                                                          margintop: 2.h,
                                                          height: 8.h,
                                                          top: 2.h,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 5.h,
                                                                width: 78.w,
                                                                margin: EdgeInsets.only(
                                                                  left: 6.w,
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    CustomWidgets.text(
                                                                      activityController.weekActivityList[index].title.toString(),
                                                                      maxLine: 1,
                                                                      softWrap: true,
                                                                      fontSize: 12.sp,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontWeight: FontWeight.w800,
                                                                    ),
                                                                    CustomWidgets.text(
                                                                      formattedDateTime.toString(),
                                                                      fontSize: 10.sp,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                )
                                              : Container(),
                                          activityController.otherActivityList.isNotEmpty
                                              ? Container(
                                                  height: 3.h,
                                                  width: 25.w,
                                                  margin: EdgeInsets.only(
                                                    right: 66.w,
                                                  ),
                                                  child: CustomWidgets.text(
                                                    "Other",
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )
                                              : Container(),
                                          //other activity
                                          activityController.otherActivityList.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  reverse: true,
                                                  itemCount: activityController.otherActivityList.length,
                                                  physics: const BouncingScrollPhysics(),
                                                  padding: EdgeInsets.only(
                                                    left: 5.w,
                                                    right: 5.w,
                                                    top: 1.h,
                                                    bottom: 3.h,
                                                  ),
                                                  itemBuilder: (context, index) {
                                                    DateTime utcDateTime =
                                                        DateTime.parse(activityController.otherActivityList[index].dateTime.toString());
                                                    DateTime localDateTime = utcDateTime.toLocal();
                                                    String formattedDateTime = DateFormat('d MMM, yyyy').format(localDateTime);
                                                    return GestureDetector(
                                                        onTap: () {
                                                          if (activityController.otherActivityList[index].bookingDetail != null) {
                                                            Get.toNamed(Routes.BOOK_ACTIVITY_DETAILS_SCREEN,
                                                                arguments: [activityController.otherActivityList[index], formattedDateTime]);
                                                          } else {
                                                            Get.toNamed(Routes.ENQUIRE_ACTIVITY_DETAILS_SCREEN,
                                                                arguments: [activityController.otherActivityList[index], formattedDateTime]);
                                                          }
                                                        },
                                                        child: CustomWidgets.customContainer(
                                                          margintop: 2.h,
                                                          height: 8.h,
                                                          top: 2.h,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 5.h,
                                                                width: 78.w,
                                                                margin: EdgeInsets.only(
                                                                  left: 6.w,
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    CustomWidgets.text(
                                                                      activityController.otherActivityList[index].title.toString(),
                                                                      maxLine: 1,
                                                                      softWrap: true,
                                                                      fontSize: 12.sp,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontWeight: FontWeight.w800,
                                                                    ),
                                                                    CustomWidgets.text(
                                                                      formattedDateTime.toString(),
                                                                      fontSize: 10.sp,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                )
                                              : Container(),
                                        ],
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 300),
                                        child: Center(
                                          child: CustomWidgets.text('No activity found', fontSize: 13.sp),
                                        ),
                                      )
                                : Padding(
                                    padding: EdgeInsets.only(top: 35.h),
                                    child: CustomWidgets.text(
                                      "You have to login to see the activity.",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.btnSelect,
                                    ),
                                  ),
                          ],
                        )
                      : CustomWidgets.NoInertnet(top: 250),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
