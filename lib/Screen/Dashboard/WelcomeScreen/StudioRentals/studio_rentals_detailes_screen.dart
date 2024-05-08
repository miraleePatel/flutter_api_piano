// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Controller/booking_controller.dart';
import 'package:piano_project/Data/Model/studio_rental_model.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/authetication_controller.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class StudioRentalsDetailesScreen extends StatefulWidget {
  const StudioRentalsDetailesScreen({Key? key}) : super(key: key);

  @override
  State<StudioRentalsDetailesScreen> createState() => _StudioRentalsDetailesScreenState();
}

class _StudioRentalsDetailesScreenState extends State<StudioRentalsDetailesScreen> {
  BookingController bookingController = Get.put(BookingController());
  StudioData studioData = Get.arguments;
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
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Image.asset(backgroundImage),
              Obx(() {
                return Column(
                  children: [
                    CustomWidgets.CustAppbar(
                      title: studioData.name.toString(),
                    ),
                    isInternetAvailable.value == true
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomWidgets.customContainer(
                                  margintop: 0.h,
                                  top: 14.h,
                                  height: 75.h,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      //studio rental image
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 20.h,
                                            width: 85.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                5.sp,
                                              ),
                                              image: DecorationImage(
                                                image: CachedNetworkImageProvider(
                                                  '$imageUrl${studioData.file}',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 53.h,
                                          margin: EdgeInsets.only(
                                            left: 3.w,
                                            right: 3.w,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SingleChildScrollView(
                                                  physics: const BouncingScrollPhysics(),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // studio rental price
                                                      RichText(
                                                        text: TextSpan(
                                                          text: 'AED ${studioData.hourlyRate.toString()}',
                                                          style: TextStyle(
                                                            color: CustomColor.black,
                                                            fontFamily: 'minion-pro-cufonfonts',
                                                            fontSize: 12.5.sp,
                                                            fontWeight: FontWeight.w800,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: ' per hour | ',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.normal,
                                                                fontSize: 11.5.sp,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "AED ${studioData.for10Classes.toString()}",
                                                              style: const TextStyle(),
                                                            ),
                                                            TextSpan(
                                                              text: ' for 10 HOURS',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.normal,
                                                                fontSize: 11.5.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      //studio rental description
                                                      CustomWidgets.text(studioData.desc!, fontSize: 9.5.sp),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                //studio rental dimension
                                                CustomWidgets.text("Dimension : ${studioData.dimension ?? "-"}", fontSize: 9.5.sp),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                //studio rental categories
                                                SizedBox(
                                                  height: 25.h,
                                                  child: ListView.separated(
                                                    itemCount: studioData.categories!.length,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, index) {
                                                      return Container(
                                                        width: 25.w,
                                                        padding: EdgeInsets.only(
                                                          left: 1.w,
                                                          right: 1.w,
                                                          top: 1.h,
                                                          bottom: 1.h,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: CustomColor.btnBCon,
                                                          border: Border.all(
                                                            color: CustomColor.btnGridConBorder,
                                                          ),
                                                          borderRadius: BorderRadius.circular(
                                                            8.sp,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                height: 10.h,
                                                                width: 20.w,
                                                                decoration: BoxDecoration(
                                                                  color: CustomColor.btnCon,
                                                                  borderRadius: BorderRadius.circular(
                                                                    4.sp,
                                                                  ),
                                                                ),
                                                                child: Image.network(
                                                                  '$imageUrl${studioData.categories![index].file}',
                                                                  scale: 3,
                                                                ),
                                                              ),
                                                              CustomWidgets.text(
                                                                studioData.categories![index].name!,
                                                                softWrap: true,
                                                                fontSize: 8.sp,
                                                                textAlign: TextAlign.center,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                              Divider(
                                                                height: 0.h,
                                                                endIndent: 4.w,
                                                                indent: 4.w,
                                                                thickness: 1,
                                                              ),
                                                              CustomWidgets.text(studioData.categories![index].desc!,
                                                                  softWrap: true,
                                                                  textAlign: TextAlign.center,
                                                                  fontSize: 7.sp,
                                                                  fontWeight: FontWeight.w600,
                                                                  maxLine: 5),
                                                              const SizedBox()
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder: (context, index) {
                                                      return SizedBox(
                                                        width: 2.5.w,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //book now
                                CustomButton(
                                  width: 90.w,
                                  onPressed: () {
                                    bool isCheck = getVerifyStatus();

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
                                        Get.toNamed(Routes.BOOKING_SCREEN, arguments: [studioData.sId, "studioscreen", "hourly"]);
                                      }
                                    }
                                  },
                                  text: 'Book Now',
                                ),
                              ],
                            ),
                          )
                        : CustomWidgets.NoInertnet(top: 200),
                    SizedBox(
                      height: 2.h,
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
