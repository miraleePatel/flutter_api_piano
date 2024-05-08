import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/welcome_controller.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class StudioRentalBookScreen extends StatefulWidget {
  const StudioRentalBookScreen({super.key});

  @override
  State<StudioRentalBookScreen> createState() => _StudioRentalBookScreenState();
}

class _StudioRentalBookScreenState extends State<StudioRentalBookScreen> {
  WelcomeController welcomeController = Get.find();
  @override
  void initState() {
    welcomeController.getStudioBookUserDataApi(
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
                  CustomWidgets.CustAppbar(title: 'Registered Studio Rental'),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () {
                          return isInternetAvailable.value == true
                              ? RefreshIndicator(
                                  color: CustomColor.btn,
                                  onRefresh: () async {
                                    await welcomeController
                                        .getStudioBookUserDataApi(
                                      userId: LoginSuccessModel.fromJson(
                                        GetStorage().read(
                                          userData,
                                        ),
                                      ).data!.sId.toString(),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 100.h,
                                    child: welcomeController
                                            .bookStudioUserList.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            itemCount: welcomeController
                                                .bookStudioUserList.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  Get.toNamed(
                                                    Routes
                                                        .CANCEL_BOOKED_STUDIO_SCREEN,
                                                    arguments: welcomeController
                                                            .bookStudioUserList[
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
                                                                      .bookStudioUserList[
                                                                          index]
                                                                      .file!),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.w,
                                                      ),
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomWidgets.text(
                                                              welcomeController
                                                                  .bookStudioUserList[
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
                                                              text1:
                                                                  'Booking Date : ',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              fontSize: 10.sp,
                                                              text2:
                                                                  '${welcomeController.bookStudioUserList[index].bookDate}'),
                                                          CustomWidgets().buildRichText(
                                                              text1:
                                                                  'Total Hour : ',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              fontSize: 10.sp,
                                                              text2:
                                                                  '${welcomeController.bookStudioUserList[index].timeSlot!.length.toString()} Hour'),
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : Center(
                                            child: CustomWidgets.text(
                                                'No Studio Rental are available',
                                                fontSize: 13.sp),
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
