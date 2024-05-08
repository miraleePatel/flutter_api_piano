// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, sized_box_for_whitespace, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/authetication_controller.dart';
import '../../../../Data/Model/get_all_concert_category.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class ConsertHallRentalsDetailesScreen extends StatefulWidget {
  const ConsertHallRentalsDetailesScreen({Key? key}) : super(key: key);

  @override
  State<ConsertHallRentalsDetailesScreen> createState() => _ConsertHallRentalsDetailesScreenState();
}

class _ConsertHallRentalsDetailesScreenState extends State<ConsertHallRentalsDetailesScreen> {
  GetAllConcertCategory concertCategory = Get.arguments;
  AuthController authController = Get.put(
    AuthController(),
  );

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
                      CustomWidgets.CustAppbar(
                        title: concertCategory.name!,
                      ),
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
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: SizedBox(
                                          height: 20.h,
                                          width: 85.w,
                                          child: (concertCategory.file != null)
                                              ? CustomWidgets.customImage(
                                                  image: '${concertCategory.file}',
                                                )
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomWidgets.text(
                                                fontSize: 10.sp,
                                                concertCategory.desc!,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              // price
                                              concertCategory.price != null && concertCategory.price != ""
                                                  ? CustomWidgets().buildRichText(
                                                      text1: 'Price :\t\t',
                                                      text2: 'AED\t\t ${concertCategory.price}\t\t[\t${concertCategory.priceDetail}\t]',
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              //notes
                                              concertCategory.note != null && concertCategory.note != ""
                                                  ? Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        CustomWidgets.text(
                                                            color: CustomColor.btn, fontSize: 12.sp, fontWeight: FontWeight.w800, 'Notes :\t\t'),
                                                        CustomWidgets.text(
                                                          fontSize: 10.sp,
                                                          color: CustomColor.black,
                                                          '${concertCategory.note}',
                                                        )
                                                      ],
                                                    )
                                                  : Container(),

                                              SizedBox(
                                                height: 1.h,
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

                      // book now
                      isInternetAvailable.value == true
                          ? CustomButton(
                              width: 90.w,
                              onPressed: () {
                                bool isCheck = getVerifyStatus();

                                print('isCheck ::: ${isCheck}');
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
                                    Get.toNamed(Routes.BOOKING_SCREEN, arguments: [concertCategory.sId, "concertscreen", ""]);
                                  }
                                }
                              },
                              text: 'Book Now',
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
}
