// ignore_for_file: non_constant_identifier_names, unnecessary_new, prefer_interpolation_to_compose_strings, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Controller/welcome_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/authetication_controller.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class EventConcertScreen extends StatefulWidget {
  const EventConcertScreen({Key? key}) : super(key: key);

  @override
  State<EventConcertScreen> createState() => _EventConcertScreenState();
}

class _EventConcertScreenState extends State<EventConcertScreen> with SingleTickerProviderStateMixin {
  WelcomeController welcomeController = Get.put(WelcomeController());
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    welcomeController.eventsDataApi();
    welcomeController.isEvent.value = false;
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
              Image.asset(backgroundImage),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 1.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back(closeOverlays: true, result: true);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: CustomColor.btn,
                            size: SizerUtil.deviceType == DeviceType.mobile ? 20 : 30,
                          ),
                        ),
                        CustomWidgets.text(
                          "Events & Concerts",
                          fontWeight: FontWeight.w800,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 15.sp : 12.sp,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              bool isCheck = getVerifyStatus();

                              print('isCheck ::: $isCheck');

                              if (getAuthToken() == "") {
                                Get.toNamed(
                                  Routes.LOGIN_SCREEN,
                                );
                              } else {
                                Get.toNamed(Routes.EVENT_CONSERT_BOOK_SCREEN);
                              }
                            },
                            child: SizedBox(
                              width: 9.w,
                              child: Image.asset(
                                bookhistory,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                      ),
                      child: Obx(
                        () {
                          // no internet connection
                          return isInternetAvailable.value == true
                              ? Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      CustomWidgets.text(
                                        "HOUSE OF PIANOS proudly presents community concerts for the\n  community of musical lovers in uae. we provide platform and\n support artists of all genres and walks of life to share their talent and\n passion for music on stage.",
                                        softWrap: true,
                                        fontSize: SizerUtil.deviceType == DeviceType.mobile ? 9.5.sp : 7.5.sp,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Upcoming events tab
                                          GestureDetector(
                                            onTap: () {
                                              welcomeController.isEvent.value = false;
                                              welcomeController.filterUpcomingEvent();
                                              print("Upcoming events: ${welcomeController.upcomingEventList}");
                                            },
                                            child: Container(
                                              height: 4.7.h,
                                              width: 43.w,
                                              decoration: BoxDecoration(
                                                color: welcomeController.isEvent.value == false ? CustomColor.btnSelect : CustomColor.black,
                                                borderRadius: BorderRadius.circular(
                                                  5.sp,
                                                ),
                                              ),
                                              child: Center(
                                                child: CustomWidgets.text(
                                                  "Upcoming Events",
                                                  color: CustomColor.white,
                                                  softWrap: true,
                                                  fontSize: SizerUtil.deviceType == DeviceType.mobile ? 8.5.sp : 7.5.sp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //pastEventList events tab
                                          GestureDetector(
                                            onTap: () {
                                              welcomeController.isEvent.value = true;
                                              welcomeController.filterPastEvent();
                                              print("pastEventList events: ${welcomeController.pastEventList}");
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 1.5.w,
                                                left: 1.5.w,
                                              ),
                                              height: 4.7.h,
                                              width: 43.w,
                                              decoration: BoxDecoration(
                                                color: welcomeController.isEvent.value == true ? CustomColor.btnSelect : CustomColor.black,
                                                borderRadius: BorderRadius.circular(
                                                  5.sp,
                                                ),
                                              ),
                                              child: Center(
                                                child: CustomWidgets.text(
                                                  "Past Events",
                                                  color: CustomColor.white,
                                                  softWrap: true,
                                                  fontSize: SizerUtil.deviceType == DeviceType.mobile ? 8.5.sp : 7.5.sp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Expanded(
                                        child: (welcomeController.isEvent.value == true)
                                            // past events
                                            ? RefreshIndicator(
                                                color: CustomColor.btn,
                                                onRefresh: () async {
                                                  await welcomeController.eventsDataApi(isLoaderShow: false);
                                                },
                                                child: SizedBox(
                                                  height: 100.h,
                                                  child: welcomeController.pastEventList.isNotEmpty
                                                      ? ListView.builder(
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: welcomeController.pastEventList.length,
                                                          itemBuilder: (context, index) {
                                                            DateTime EventDate =
                                                                new DateFormat("dd/MM/yyyy").parse("${welcomeController.pastEventList[index].date}");
                                                            var date = DateFormat("d ").format(EventDate);
                                                            var month = DateFormat("MMM ").format(EventDate);
                                                            var year = DateFormat("yy").format(EventDate);

                                                            return GestureDetector(
                                                              onTap: () {
                                                                bool isCheck = getVerifyStatus();

                                                                print('isCheck ::: $isCheck');
                                                                if (welcomeController.isEvent.value == true) {
                                                                  if (getAuthToken() == "") {
                                                                    Get.toNamed(
                                                                      Routes.LOGIN_SCREEN,
                                                                    );
                                                                  } else {
                                                                    Get.toNamed(Routes.PAST_EVENT_DETAILS_SCREEN,
                                                                        arguments: welcomeController.pastEventList[index]);
                                                                  }
                                                                }
                                                              },
                                                              child: CustomWidgets.customContainer(
                                                                  margintop: 2.h,
                                                                  top: 3.h,
                                                                  height: 17.h,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 4.w,
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        child: SizedBox(
                                                                          height: 10.5.h,
                                                                          width: 20.5.w,
                                                                          child: welcomeController.pastEventList[index].file != null
                                                                              ? CustomWidgets.customImage(
                                                                                  image: welcomeController.pastEventList[index].file!)
                                                                              : CustomWidgets.NoImage(),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 3.w,
                                                                      ),
                                                                      Expanded(
                                                                          child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height: 3.w,
                                                                          ),
                                                                          CustomWidgets.text(welcomeController.pastEventList[index].name!,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w800,
                                                                              maxLine: 1,
                                                                              overflow: TextOverflow.ellipsis),
                                                                          CustomWidgets().buildRichText(
                                                                              text1: 'Artist : ',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 1,
                                                                              text2: welcomeController.pastEventList[index].artist == "" ||
                                                                                      welcomeController.pastEventList[index].artist == null
                                                                                  ? "  -  "
                                                                                  : '${welcomeController.pastEventList[index].artist}'),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              CustomWidgets.text(
                                                                                'Date : ',
                                                                                color: CustomColor.btn,
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w800,
                                                                              ),
                                                                              CustomWidgets.text(
                                                                                date,
                                                                                fontSize: 11.sp,
                                                                                fontWeight: FontWeight.w800,
                                                                              ),
                                                                              CustomWidgets.text(
                                                                                month + "'" + year,
                                                                                fontSize: 10.sp,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          CustomWidgets().buildRichText(
                                                                              text1: 'Venue : ',
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontSize: 10.sp,
                                                                              text2: '${welcomeController.pastEventList[index].venue}'),
                                                                        ],
                                                                      )),
                                                                      SizedBox(
                                                                        width: 2.w,
                                                                      ),
                                                                      Container(
                                                                        child: CustomWidgets.customIcon(),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 4.w,
                                                                      ),
                                                                    ],
                                                                  )),
                                                            );
                                                          })
                                                      : Center(
                                                          child: CustomWidgets.text('No events are available', fontSize: 13.sp),
                                                        ),
                                                ),
                                              )
                                            // Upcoming events
                                            : RefreshIndicator(
                                                color: CustomColor.btn,
                                                onRefresh: () async {
                                                  await welcomeController.eventsDataApi(isLoaderShow: false);
                                                },
                                                child: SizedBox(
                                                  height: 100.h,
                                                  child: welcomeController.upcomingEventList.isNotEmpty
                                                      ? ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.vertical,
                                                          itemCount: welcomeController.upcomingEventList.length,
                                                          itemBuilder: (context, index) {
                                                            DateTime EventDate = new DateFormat("dd/MM/yyyy")
                                                                .parse("${welcomeController.upcomingEventList[index].date}");
                                                            var date = DateFormat("d ").format(EventDate);
                                                            var month = DateFormat("MMM ").format(EventDate);
                                                            var year = DateFormat("yy").format(EventDate);

                                                            return GestureDetector(
                                                              onTap: () {
                                                                bool isCheck = getVerifyStatus();

                                                                print('isCheck ::: $isCheck');
                                                                if (welcomeController.isEvent.value == false) {
                                                                  if (getAuthToken() == "") {
                                                                    Get.toNamed(
                                                                      Routes.LOGIN_SCREEN,
                                                                    );
                                                                  } else {
                                                                    if (authController.loginDetails.value.data!.phoneNo == null ||
                                                                        authController.loginDetails.value.data!.phoneNo == "null" ||
                                                                        authController.loginDetails.value.data!.phoneNo == "" ||
                                                                        authController.loginDetails.value.data!.countryCode == null ||
                                                                        authController.loginDetails.value.data!.file == null) {
                                                                      clearMobileDialog();
                                                                      addMobileDialog(context, onTapMethod: () async {
                                                                        editProfileController.editUserDetails(
                                                                          LoginSuccessModel.fromJson(
                                                                            GetStorage().read(
                                                                              userData,
                                                                            ),
                                                                          ).data!.sId.toString(),
                                                                          fullName: authController.loginDetails.value.data!.fullName.toString(),
                                                                          file: "${flagM.value}.png",
                                                                          countryCode: contryCodeM.value,
                                                                          phoneNo: mobileController.text,
                                                                          address: authController.loginDetails.value.data!.address.toString(),
                                                                        );
                                                                      });
                                                                    } else {
                                                                      Get.toNamed(Routes.UPCOMING_EVENT_DETAILS_SCREEN,
                                                                          arguments: welcomeController.upcomingEventList[index]);
                                                                    }
                                                                  }
                                                                }
                                                              },
                                                              child: CustomWidgets.customContainer(
                                                                  margintop: 2.h,
                                                                  top: 3.h,
                                                                  height: 17.h,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 4.w,
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        child: SizedBox(
                                                                          height: SizerUtil.deviceType == DeviceType.mobile ? 10.5.h : 13.h,
                                                                          width: SizerUtil.deviceType == DeviceType.mobile ? 20.5.w : 22.w,
                                                                          child: welcomeController.upcomingEventList[index].file != null
                                                                              ? CustomWidgets.customImage(
                                                                                  image: welcomeController.upcomingEventList[index].file.toString())
                                                                              : CustomWidgets.NoImage(),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 3.w,
                                                                      ),
                                                                      Expanded(
                                                                          child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height: 3.w,
                                                                          ),
                                                                          CustomWidgets.text(welcomeController.upcomingEventList[index].name!,
                                                                              fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 10.sp,
                                                                              fontWeight: FontWeight.w800,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLine: 1),
                                                                          CustomWidgets().buildRichText(
                                                                              text1: 'Artist : ',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 1,
                                                                              fontSize1: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
                                                                              fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 7.sp,
                                                                              text2: welcomeController.upcomingEventList[index].artist == "" ||
                                                                                      welcomeController.upcomingEventList[index].artist == null
                                                                                  ? "  -  "
                                                                                  : '${welcomeController.upcomingEventList[index].artist}'),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              CustomWidgets.text(
                                                                                'Date : ',
                                                                                color: CustomColor.btn,
                                                                                fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
                                                                                fontWeight: FontWeight.w800,
                                                                              ),
                                                                              CustomWidgets.text(
                                                                                date,
                                                                                fontSize: SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 7.sp,
                                                                                fontWeight: FontWeight.w800,
                                                                              ),
                                                                              CustomWidgets.text(
                                                                                month + "'" + year,
                                                                                fontSize: SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 7.sp,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          CustomWidgets().buildRichText(
                                                                              text1: 'Venue : ',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 2,
                                                                              fontSize1: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
                                                                              fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 7.sp,
                                                                              text2: '${welcomeController.upcomingEventList[index].venue}'),
                                                                        ],
                                                                      )),
                                                                      SizedBox(
                                                                        width: 2.w,
                                                                      ),
                                                                      Container(
                                                                        child: CustomWidgets.customIcon(),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 4.w,
                                                                      ),
                                                                    ],
                                                                  )),
                                                            );
                                                          })
                                                      : Center(
                                                          child: CustomWidgets.text('No events are available', fontSize: 13.sp),
                                                        ),
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      )
                                    ],
                                  ),
                                )
                              : CustomWidgets.NoInertnet(top: 200);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
