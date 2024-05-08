import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Data/Model/login_response_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/welcome_controller.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class ConcertHallBookScreen extends StatefulWidget {
  const ConcertHallBookScreen({super.key});

  @override
  State<ConcertHallBookScreen> createState() => _ConcertHallBookScreenState();
}

class _ConcertHallBookScreenState extends State<ConcertHallBookScreen> {
    WelcomeController welcomeController = Get.find();
  @override
  void initState() {
    welcomeController.getConcertBookUserDataApi(
        userId: LoginSuccessModel.fromJson(
      GetStorage().read(
        userData,
      ),
    ).data!.sId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
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
                  CustomWidgets.CustAppbar(title: 'Registered Concert Hall'),
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
                                    await welcomeController
                                        .getConcertBookUserDataApi(
                                            userId: LoginSuccessModel.fromJson(
                                      GetStorage().read(
                                        userData,
                                      ),
                                    ).data!.sId.toString());
                                  },
                                  child: SizedBox(
                                    height: 100.h,
                                    child: welcomeController
                                            .bookConcertUserList.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            itemCount: welcomeController
                                                .bookConcertUserList.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  Get.toNamed(
                                                    Routes
                                                        .CANCEL_BOOKED_CONCERT_SCREEN,
                                                    arguments: welcomeController
                                                            .bookConcertUserList[
                                                        index],
                                                  );
                                                },
                                                child: CustomWidgets
                                                    .customContainer(
                                                  margintop: 2.h,
                                                  top: 3.h,
                                                  height: 14.5.h,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 4.w,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: SizedBox(
                                                          height: 10.5.h,
                                                          width: 20.5.w,
                                                          child: CustomWidgets
                                                              .customImage(
                                                                  image: welcomeController
                                                                      .bookConcertUserList[
                                                                          index]
                                                                      .file!),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.w,
                                                      ),
                                                      Expanded(
                                                          child: Column(mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          CustomWidgets.text(
                                                              welcomeController
                                                                  .bookConcertUserList[
                                                                      index]
                                                                  .name!,
                                                              fontSize: 12.sp,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              maxLine: 1),
                                                              CustomWidgets().buildRichText(
                                                                              text1: 'Booking Date : ',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 2,
                                                                              fontSize: 10.sp,
                                                                              text2: '${welcomeController.bookConcertUserList[index].bookDate}'),
                                                             CustomWidgets().buildRichText(
                                                                              text1: 'Total Hour : ',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 2,
                                                                              fontSize: 10.sp,
                                                                              text2: '${welcomeController.bookConcertUserList[index].timeSlot!.length.toString()} Hour'),
                                                                         
                                                           
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              );

                                             })
                                        : Center(
                                            child: CustomWidgets.text(
                                                'No Concert Hall are available',
                                                fontSize: 13.sp),
                                          ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 200),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 20.h,
                                        child: Image.asset(
                                          noInternet,
                                          scale: 9,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
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