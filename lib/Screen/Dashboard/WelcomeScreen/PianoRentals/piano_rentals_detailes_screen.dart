// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_interpolations, avoid_print
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../Data/Model/filter_piano_model.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class PianoRentalsDetailesScreen extends StatefulWidget {
  const PianoRentalsDetailesScreen({Key? key}) : super(key: key);

  @override
  State<PianoRentalsDetailesScreen> createState() => _PianoRentalsDetailesScreenState();
}

class _PianoRentalsDetailesScreenState extends State<PianoRentalsDetailesScreen> {
  FilterPiano filterPiano = Get.arguments;
  @override
  void initState() {
    bool isEmpty = GetStorage().read(userData) != null;

    if (isEmpty == true) {
      authController.checkLoginUser(
          email: LoginSuccessModel.fromJson(
        GetStorage().read(
          userData,
        ),
      ).data!.email.toString());
    }
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
                  CustomWidgets.CustAppbar(title: "Piano Rentals"),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                        top: 1.h,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Obx(
                          () {
                            return isInternetAvailable.value == true
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      //paino heading
                                      Center(
                                        child: CustomWidgets.text(
                                          filterPiano.heading!,
                                          softWrap: true,
                                          fontSize: 13.5.sp,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      //piano tital
                                      Center(
                                        child: CustomWidgets.text(
                                          filterPiano.title!,
                                          softWrap: true,
                                          fontSize: 10.sp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      //piano description
                                      Center(
                                          child: CustomWidgets.text(
                                        filterPiano.desc!,
                                        softWrap: true,
                                        fontSize: 9.8.sp,
                                        textAlign: TextAlign.center,
                                      )),
                                      SizedBox(
                                        height: 4.h,
                                      ),

                                      CustomWidgets.customContainer(
                                        margintop: 0.h,
                                        top: 14.h,
                                        height: 70.h,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            //piano image
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 20.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: CachedNetworkImageProvider('${imageUrl}${filterPiano.file}'),
                                                        fit: BoxFit.cover,
                                                        scale: 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Container(
                                              height: 36.h,
                                              margin: EdgeInsets.only(
                                                left: 7.w,
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  //piano brand
                                                  CustomWidgets().buildRichText(
                                                      text1: 'Brand: ',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      fontSize: 10.sp,
                                                      text2: '${filterPiano.brand!}'),

                                                  //piano model
                                                  CustomWidgets().buildRichText(
                                                      text1: 'Model: ',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      fontSize: 10.sp,
                                                      text2: '${filterPiano.model!}'),
                                                  //piano color
                                                  CustomWidgets().buildRichText(
                                                      text1: 'Color: ',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      fontSize: 10.sp,
                                                      text2: '${filterPiano.color!}'),
                                                  //pinao Dimension
                                                  CustomWidgets().buildRichText(
                                                    text1: 'Dimension: ',
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 10.sp,
                                                    text2: '${filterPiano.dimension!}',
                                                  ),
                                                  Divider(
                                                    height: 5.h,
                                                    endIndent: 62.w,
                                                    thickness: 1,
                                                  ),
                                                  CustomWidgets.text(
                                                    'Our Services Include: ',
                                                    color: CustomColor.btn,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.sp,
                                                  ),
                                                  CustomWidgets.text(
                                                    'Delivery',
                                                  ),
                                                  CustomWidgets.text(
                                                    'Installation',
                                                  ),
                                                  CustomWidgets.text(
                                                    'Tuning',
                                                  ),
                                                  CustomWidgets.text(
                                                    'Collection',
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  CustomWidgets().buildRichText(
                                                    text1: 'We Deliver & Service to ',
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize1: 12.sp,
                                                    fontSize: 12.sp,
                                                    text2: "all GCC Countries",
                                                    fontWeight2: FontWeight.w800,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      CustomButton(
                                        onPressed: () {
                                          bool isCheck = getVerifyStatus();

                                          print('isCheck ::: ${isCheck}');
                                          if (getAuthToken() == "") {
                                            Get.toNamed(Routes.LOGIN_SCREEN);
                                          } else {
                                            // enqury alert
                                            if (authController.loginDetails.value.data!.phoneNo == null ||
                                                authController.loginDetails.value.data!.phoneNo == "null" ||
                                                authController.loginDetails.value.data!.phoneNo == "" ||
                                                authController.loginDetails.value.data!.countryCode == null ||
                                                authController.loginDetails.value.data!.file == null) {
                                              addMobileDialog(context, onTapMethod: () async {
                                                clearMobileDialog();
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
                                              enquireAlert(
                                                  context: context,
                                                  servicesId: filterPiano.sId.toString(),
                                                  serviceName: "Piano Rental",
                                                  serviceType: filterPiano.brand!,
                                                  userid: LoginSuccessModel.fromJson(
                                                    GetStorage().read(
                                                      userData,
                                                    ),
                                                  ).data!.sId.toString(),
                                                  isService: false);
                                            }
                                          }
                                        },
                                        text: 'Enquire Now',
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                    ],
                                  )
                                : CustomWidgets.NoInertnet(top: 200);
                          },
                        ),
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
