// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, unnecessary_brace_in_string_interps, unnecessary_null_comparison, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Data/Model/login_response_model.dart';
import 'package:piano_project/Utils/app_color.dart';
import 'package:piano_project/Utils/constant_widgets.dart';
import 'package:piano_project/Widget/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../Data/Model/concert_hall_booking_response_model.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class CancelBookedConcertScreen extends StatefulWidget {
  const CancelBookedConcertScreen({super.key});

  @override
  State<CancelBookedConcertScreen> createState() => _CancelBookedConcertScreenState();
}

class _CancelBookedConcertScreenState extends State<CancelBookedConcertScreen> {
  ConcertBookUserData bookUserData = Get.arguments;
  var lasttime;
  var date;
  @override
  void initState() {
    super.initState();
    welcomeController.getConcertBookUserDataApi(
        userId: LoginSuccessModel.fromJson(
      GetStorage().read(
        userData,
      ),
    ).data!.sId.toString());
    var newDate = DateFormat("dd/MM/yyyy").parse(bookUserData.bookDate.toString());

    date = DateFormat('d MMMM, yyyy').format(DateTime.parse(newDate.toString()));
    bookingController.agree.value = false;
    lasttime = bookingController.getNextHour("${bookUserData.timeSlot!.last.split(" - ").last}");
  }

  @override
  void dispose() {
    authController.clearRigesterData();
    super.dispose();
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
                      CustomWidgets.CustAppbar(title: bookUserData.name.toString()),
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
                                        height: 25.h,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          child: (bookUserData.file != null)
                                              ? CustomWidgets.customImage(fit: BoxFit.fill, image: bookUserData.file!)
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
                                              //booking date
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
                                                      bookUserData.bookDate != null ? '${date}' : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //time slot
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
                                                    child: bookUserData.timeSlot!.isNotEmpty && bookUserData.timeSlot!.isNotEmpty != null
                                                        ? CustomWidgets.text(
                                                            "${bookUserData.timeSlot!.first.split(" - ").first} - ${lasttime}",
                                                            textAlign: TextAlign.start,
                                                            fontSize: 11.sp,
                                                          )
                                                        : CustomWidgets.text(
                                                            "-",
                                                            textAlign: TextAlign.start,
                                                            fontSize: 11.sp,
                                                          ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),

                                              //price
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    price,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text(
                                                      bookUserData.price != null
                                                          // ? '${bookUserData.price} AED - ${bookUserData.priceDetail}'
                                                          ? '${bookUserData.price} AED'
                                                          : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //pricek kar
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    amount,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text(
                                                      bookUserData.price != null
                                                          // ? '${bookUserData.price} AED - ${bookUserData.priceDetail}'
                                                          ? '${bookUserData.priceDetail}'
                                                          : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              // plan
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
                                                      bookUserData.desc != null ? '${bookUserData.desc}' : '  -  ',
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              //T & C
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    terms,
                                                    scale: 2.5,
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Expanded(
                                                    child: CustomWidgets.text(
                                                      welcomeController.concerthallTerms.value.toString(),
                                                      color: CustomColor.btn,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                width: 4.h,
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
                          : CustomWidgets.NoInertnet(bottom: 100),
                      isInternetAvailable.value == true
                          ? bookUserData.cancelBooking == true
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            activeColor: CustomColor.btn,
                                            value: bookingController.agree.value,
                                            onChanged: (value) {
                                              bookingController.agree.value = !bookingController.agree.value;
                                            },
                                          ),
                                          Expanded(
                                            child: CustomWidgets.text('I have read and accept terms and conditions',
                                                overflow: TextOverflow.ellipsis, maxLine: 2, fontWeight: FontWeight.w800, fontSize: 10.sp),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    CustomButton(
                                      text: "Cancel Booking",
                                      onPressed: bookingController.agree.value
                                          ? () {
                                              if (authController.loginDetails.value.data!.phoneNo == null ||
                                                  authController.loginDetails.value.data!.phoneNo == "null" ||
                                                  authController.loginDetails.value.data!.phoneNo == "" ||
                                                  authController.loginDetails.value.data!.countryCode == null ||
                                                  authController.loginDetails.value.data!.file == null) {
                                                addMobileDialog(context, onTapMethod: () async {
                                                  editProfileController.editUserDetails(
                                                    LoginSuccessModel.fromJson(
                                                      GetStorage().read(
                                                        userData,
                                                      ),
                                                    ).data!.sId.toString(),
                                                    file: "${authController.flag.value}.png",
                                                    fullName: authController.loginDetails.value.data!.fullName.toString(),
                                                    countryCode: authController.contryCode.value,
                                                    phoneNo: authController.phController.text,
                                                    address: authController.loginDetails.value.data!.address.toString(),
                                                  );
                                                });
                                              } else {
                                                CancelBookingAlert(
                                                  context: context,
                                                  onPressed: () {
                                                    welcomeController.ConcertBookingCancelDataApi(
                                                      bookingId: bookUserData.bookingId.toString(),
                                                      userId: LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                    );
                                                  },
                                                );
                                              }
                                            }
                                          : () {
                                              informationSnackBar(message: 'Please accept terms and conditions');
                                            },
                                      width: 90.w,
                                      color: Colors.red.withOpacity(
                                        0.9,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 2.h,
                                )
                          : Container(),
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
