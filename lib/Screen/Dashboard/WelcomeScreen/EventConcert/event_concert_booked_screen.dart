// ignore_for_file: unnecessary_new, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/welcome_controller.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class EventConcertBookScreen extends StatefulWidget {
  const EventConcertBookScreen({super.key});

  @override
  State<EventConcertBookScreen> createState() => _EventConcertBookScreenState();
}

class _EventConcertBookScreenState extends State<EventConcertBookScreen> {
  WelcomeController welcomeController = Get.find();

  @override
  void initState() {
    welcomeController.getEventBookUserDataApi(
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
              Image.asset(backgroundImage),
              Column(
                children: [
                  CustomWidgets.CustAppbar(title: 'Registered slots'),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () {
                          // no internet connection
                          return isInternetAvailable.value == true
                              ? RefreshIndicator(
                                  color: CustomColor.btn,
                                  onRefresh: () async {
                                    await welcomeController.getEventBookUserDataApi(
                                        userId: LoginSuccessModel.fromJson(
                                      GetStorage().read(
                                        userData,
                                      ),
                                    ).data!.sId.toString());
                                  },
                                  child: SizedBox(
                                    height: 100.h,
                                    child: welcomeController.bookEventUserList.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(bottom: 2.h),
                                            itemCount: welcomeController.bookEventUserList.length,
                                            itemBuilder: (context, index) {
                                              DateTime EventDate =
                                                  new DateFormat("dd/MM/yyyy").parse("${welcomeController.bookEventUserList[index].date}");
                                              var date = DateFormat("d ").format(EventDate);
                                              var month = DateFormat("MMM ").format(EventDate);
                                              var year = DateFormat("yy").format(EventDate);

                                              return GestureDetector(
                                                onTap: () async {
                                                  Get.toNamed(Routes.EVENT_BOOK_USER_DETAILS_SCREEN,
                                                      arguments: welcomeController.bookEventUserList[index]);
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
                                                            child: CustomWidgets.customImage(image: welcomeController.bookEventUserList[index].file!),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              CustomWidgets.text(welcomeController.bookEventUserList[index].name!,
                                                                  fontSize: 12.sp,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.w800,
                                                                  maxLine: 1),
                                                              CustomWidgets().buildRichText(
                                                                  text1: 'Artist : ',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  maxLines: 1,
                                                                  text2: welcomeController.bookEventUserList[index].artist == "" ||
                                                                          welcomeController.bookEventUserList[index].artist == null
                                                                      ? "  -  "
                                                                      : '${welcomeController.bookEventUserList[index].artist}'),
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
                                                                  overflow: TextOverflow.ellipsis,
                                                                  maxLines: 2,
                                                                  fontSize: 10.sp,
                                                                  text2: '${welcomeController.bookEventUserList[index].venue}'),
                                                            ],
                                                          ),
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
