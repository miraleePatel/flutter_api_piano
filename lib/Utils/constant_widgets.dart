// ignore_for_file: sort_child_properties_last, unrelated_type_equality_checks, unused_import, unnecessary_null_comparison, unnecessary_string_escapes, unused_local_variable, non_constant_identifier_names, avoid_print, unused_element

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:piano_project/Controller/booking_controller.dart';
import 'package:piano_project/Controller/payment_controller.dart';
import 'package:piano_project/Controller/welcome_controller.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:piano_project/Utils/country_list.dart';
import 'package:piano_project/Widget/custom_button.dart';
import 'package:piano_project/Widget/custom_datepicker.dart';
import 'package:sizer/sizer.dart';
import '../Controller/authetication_controller.dart';
import '../Controller/calender_controller.dart';
import '../Controller/profile_controller.dart';
import '../Data/Model/apple_pay_response_model.dart';
import '../Data/Model/get_all_event_concert_model.dart';
import '../Data/Model/login_response_model.dart';
import '../Widget/custom_apple_pay_button.dart';
import '../Widget/custom_dropdown_button.dart';
import '../Widget/custom_textfield.dart';
import '../Widget/custom_widget.dart';
import 'app_color.dart';
import 'string_constants.dart';

///******************************************* Stutesbar *******************************************///

stutesbar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: CustomColor.btnAbout,
    statusBarIconBrightness: Brightness.dark,
  ));
}

///******************************************* Show progress indicator *******************************************///

showProgressIndicator() {
  stutesbar();
  return EasyLoading.show(maskType: EasyLoadingMaskType.black, status: 'Loading', dismissOnTap: false);
}

///******************************************* Dismiss progress indicator *******************************************///

dismissProgressIndicator() {
  stutesbar();
  return EasyLoading.dismiss();
}

///******************************************* Snackbar for showing error message *******************************************///

errorSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}

///******************************************* Snackbar for showing error message *******************************************///

informationSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.cyan.withOpacity(0.80),
      icon: const Icon(Icons.info_outline_rounded, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}

///******************************************* Snackbar for showing success message *******************************************///

successSnackBar({String? title, String? message, Duration? duration}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Success',
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green.withOpacity(0.80),
      icon: const Icon(Icons.task_alt_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: duration ?? const Duration(seconds: 3),
    ),
  );
}

///******************************************* Get Stored User Auth Token *******************************************///

String getAuthToken() {
  if (kDebugMode) {
    print('Auth Token getAuthTokenMethod AuthController ${GetStorage().read(authToken) ?? ''}');
  }
  return GetStorage().read(authToken) ?? '';
}

String getuserRole() {
  if (kDebugMode) {
    print('userRole ${GetStorage().read(isuserRole) ?? ''}');
  }
  return GetStorage().read(isuserRole) ?? '';
}

bool getVerifyStatus() {
  if (kDebugMode) {
    print('isVerifyEmail ${GetStorage().read(isVerifyEmail) ?? ''}');
  }
  return GetStorage().read(isVerifyEmail) ?? false;
}

///******************************************* Declare Controller *******************************************///

WelcomeController welcomeController = Get.put(WelcomeController());
TableCalenderController tableCalenderController = Get.put(TableCalenderController());
ProfileController editProfileController = Get.put(ProfileController());
BookingController bookingController = Get.put(BookingController());
ScrollController scrollController = ScrollController();
PaymentController paymentController = Get.put(PaymentController());

///******************************************* Enquire Alert *******************************************///

//First enquire alert
enquireAlert(
    {required String servicesId,
    required bool isService,
    required BuildContext context,
    required String serviceName,
    required String serviceType,
    required String userid}) {
  stutesbar();
  showDialog(
    context: context,
    builder: (
      BuildContext context,
    ) {
      return AlertDialog(
        scrollable: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        actionsPadding: EdgeInsets.zero,
        actions: [
          InkWell(
            onTap: () {
              Get.back(closeOverlays: true);
              enquireSecondAlert(
                  context: context, serviceName: serviceName, servicesId: servicesId, serviceType: serviceType, userid: userid, isService: isService);
            },
            child: Container(
              height: 5.h,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: CustomColor.btn,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: CustomWidgets.text(
                "Next",
                fontWeight: FontWeight.w600,
                color: CustomColor.white,
              ),
            ),
          ),
        ],
        contentPadding: EdgeInsets.only(
          top: 2.h,
        ),
        content: SizedBox(
          width: 150.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomWidgets.text(
                    "Enquire now",
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  InkWell(
                    child: const Icon(Icons.close),
                    onTap: () {
                      Get.back(closeOverlays: true);
                      welcomeController.date.clear();
                      welcomeController.time.clear();
                      welcomeController.locationController.clear();
                      welcomeController.noteController.clear();
                      tableCalenderController.selectedDate.value = DateTime.now();
                    },
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 48.h,
                child: const CustomDatePicker(),
                padding: EdgeInsets.only(
                  left: 2.5.w,
                  right: 2.5.w,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
            ],
          ),
        ),
      );
    },
  );
}

//secone enquire alert
enquireSecondAlert({
  required String servicesId,
  required bool isService,
  required BuildContext context,
  required String serviceName,
  required String serviceType,
  required String userid,
}) {
  stutesbar();
  final GlobalKey<FormState> key = GlobalKey();
  showDialog(
    context: context,
    builder: (
      BuildContext context,
    ) {
      return Form(
        key: key,
        child: AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            InkWell(
              onTap: () {
                if (key.currentState!.validate()) {
                  tableCalenderController.currentDate.value = DateFormat('dd/MM/yyyy').format(tableCalenderController.selectedDate.value);

                  welcomeController.enquireDataApi(
                      context: context,
                      UserId: userid,
                      location: welcomeController.locationController.text,
                      note: welcomeController.noteController.text,
                      date: tableCalenderController.currentDate.value,
                      serviceName: serviceName,
                      serviceType: serviceType,
                      servicesId: servicesId,
                      pianoType: welcomeController.selectService.value.toString(),
                      pianoBrand: welcomeController.pianobrandController.text);
                  Get.back(closeOverlays: true);

                  welcomeController.date.clear();
                  welcomeController.locationController.clear();
                  welcomeController.noteController.clear();
                  tableCalenderController.selectedDate.value = DateTime.now();
                  welcomeController.pianobrandController.clear();
                  welcomeController.selectService.value = "";
                }
              },
              child: Container(
                height: 5.h,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: CustomColor.btn,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                child: CustomWidgets.text(
                  "Submit",
                  fontWeight: FontWeight.w600,
                  color: CustomColor.white,
                ),
              ),
            ),
          ],
          contentPadding: EdgeInsets.only(
            top: 2.h,
          ),
          content: SizedBox(
            width: 150.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomWidgets.text(
                      "Enquire now",
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        Get.back(closeOverlays: true);
                        welcomeController.date.clear();
                        welcomeController.time.clear();
                        welcomeController.locationController.clear();
                        welcomeController.noteController.clear();
                        welcomeController.pianobrandController.clear();
                        tableCalenderController.selectedDate.value = DateTime.now();
                        welcomeController.selectService.value = "";
                      },
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: CustomEnquiryTextFiled(
                    validator: (String? value) {
                      if (value!.trim() == null || value.trim().isEmpty) {
                        welcomeController.locationController.clear();
                        return "Please Add Location";
                      } else {
                        return null;
                      }
                    },
                    controller: welcomeController.locationController,
                    hintText: 'Location',
                  ),
                ),
                isService == true
                    ? SizedBox(
                        height: 2.h,
                      )
                    : Container(),
                isService == true
                    ? Column(
                        children: [
                          Obx(
                            () {
                              return CustomDropDownButton(
                                value: welcomeController.selectService.value.isEmpty || welcomeController.selectService.value == ''
                                    ? null
                                    : welcomeController.selectService.value,
                                items: welcomeController.pianotypeList
                                    .map(
                                      (item) => DropdownMenuItem(
                                        value: item.type,
                                        child: CustomWidgets.text(
                                          item.type.toString(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != 'Piano Type') {
                                    welcomeController.selectService.value = value.toString();
                                  } else {
                                    welcomeController.selectService.value = '';
                                  }
                                  if (kDebugMode) {
                                    print(welcomeController.selectService.value);
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: CustomEnquiryTextFiled(
                              controller: welcomeController.pianobrandController,
                              hintText: 'Piano Brand',
                              validator: (String? value) {
                                if (value!.trim() == null || value.trim().isEmpty) {
                                  welcomeController.pianobrandController.clear();
                                  return "Please Add Piano Brand";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CustomEnquiryTextFiled(
                    controller: welcomeController.noteController,
                    hintText: 'Note',
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

///******************************************* Terms & Condition Alert *******************************************///

TermsConditionAlert({required BuildContext context, required String text, void Function()? onPressed}) {
  bookingController.agree.value = false;
  stutesbar();
  return showDialog<void>(
      context: context,
      builder: (context) {
        return Obx(() {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            actionsPadding: EdgeInsets.zero,
            scrollable: true,
            backgroundColor: CustomColor.btnBCon,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: 3.w,
                ),
                CustomWidgets.text(
                  "Terms & Conditions",
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
                InkWell(
                  child: const Icon(Icons.close),
                  onTap: () {
                    bookingController.agree.value = false;
                    Get.back(closeOverlays: true);
                  },
                ),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 2),
              child: CustomWidgets.customContainer(
                margintop: 0.h,
                top: 5.h,
                height: 33.h,
                child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: text != "null" || text != null || text != "" ? CustomWidgets.text(text, textAlign: TextAlign.justify) : Container())),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: TextButton(
                  child: CustomWidgets.text('Accept',
                      fontWeight: FontWeight.w700, fontSize: 12.sp, color: bookingController.agree.value ? CustomColor.btn : CustomColor.textBluer),
                  onPressed: bookingController.agree.value
                      ? onPressed
                      : () {
                          informationSnackBar(message: 'Please accept terms and conditions');
                        },
                ),
              ),
            ],
          );
        });
      });
}

///******************************************* Booking Cancel Alert *******************************************///

CancelBookingAlert({required BuildContext context, void Function()? onPressed}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          scrollable: true,
          backgroundColor: CustomColor.btnBCon,
          title: CustomWidgets.text('Cancel Booking'),
          content: CustomWidgets.text('Are you sure want to cancel booking?', fontSize: 13.sp),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 5.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: CustomColor.btn)),
                      child: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: CustomWidgets.text('No', color: CustomColor.btn)),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      height: 5.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: CustomColor.btn),
                      child: MaterialButton(onPressed: onPressed, child: CustomWidgets.text('Yes', color: CustomColor.white)),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ],
        );
      });
}

///******************************************* payment option bottom sheet *******************************************///

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '90.0',
    status: PaymentItemStatus.final_price,
  )
];

applePaymentSheet(BuildContext context,
    {required Function() onTapPaytabs,
    String? amount,
    required Function() onPressedApple,
    Function()? onTap,
    required String bookingIdScreen,
    required String titleText,
    required String discountAmount,
    required String bookingLabel,
    required String bookAmount
    // required String bookId,
    }) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.btnBCon,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context1) {
        return GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomWidgets.text(
                        titleText,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      const Spacer(),
                      InkWell(
                        child: const Icon(Icons.close),
                        onTap: () {
                          Get.back(closeOverlays: true);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: onTapPaytabs,
                  child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(color: CustomColor.paytabsBtn, borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomWidgets.text(
                            "Pay By card / Apple pay",
                            fontWeight: FontWeight.w800,
                            fontSize: 17.sp,
                          ),
                        ],
                      )),
                ),

                //paytabs
                /*  // apple pay
                CustomApplePayButton(
                  amount: amount,
                  onPressed: onPressedApple,
                  bookingIdScreen: bookingIdScreen,
                  bookAmount: bookAmount,
                  bookingLabel: bookingLabel,
                  discountAmount: discountAmount,
                  // bookId: bookId,
                ) */
              ],
            ),
          ),
        );
      });
}

AuthController authController = Get.put(
  AuthController(),
);
RxString flagM = 'ae'.obs;
RxString numberLenghtM = '9'.obs;
RxString contryCodeM = '+971'.obs;
TextEditingController mobileController = TextEditingController();
clearMobileDialog() {
  numberLenghtM.value = '9';
  contryCodeM.value = '+971';
  flagM.value = "ae";
  mobileController.clear();
}

addMobileDialog(BuildContext context, {required Function() onTapMethod}) {
  stutesbar();
  GlobalKey<FormState> valKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Form(
          key: valKey,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            actionsPadding: EdgeInsets.zero,
            scrollable: true,
            backgroundColor: CustomColor.btnBCon,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CustomWidgets.text(
                          "Please add mobile number",
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                        const Spacer(),
                        InkWell(
                          child: const Icon(Icons.close),
                          onTap: () async {
                            Get.back(closeOverlays: true);
                            await GoogleSignIn().signOut();
                            authController.clearRigesterData();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 80.w,
                      child: TextFormField(
                        controller: mobileController,
                        validator: (value) {
                          if (numberLenghtM != mobileController.text.split(" ").last.length.toString()) {
                            return 'Phone Number length Must be ${numberLenghtM.value}';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[' '\+\0-9\.]")),
                        ],
                        onFieldSubmitted: (value) {
                          authController.mobilenumber.value = mobileController.text;
                        },
                        onChanged: (value) {
                          authController.mobilenumber.value = mobileController.text;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: 1.h,
                            left: 4.w,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 3.w, right: 3.w),
                                height: 3.h,
                                width: 5.5.w,
                                child: Image.asset(
                                  call,
                                ),
                              ),
                              Obx(() => CustomWidgets.text("${contryCodeM.value} ", fontSize: 13.sp)),
                            ],
                          ),
                          fillColor: CustomColor.btnCont,
                          filled: true,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _showDialogOnButtonPressing(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 2.w, top: 1.h, bottom: 1.h),
                              width: 15.w,
                              height: 4.5.h,
                              child: Container(
                                width: 13.w,
                                height: 4.5.h,
                                decoration: BoxDecoration(
                                  color: CustomColor.btnDropdown,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 0.5.w,
                                      ),
                                      child: Obx(() => Container(
                                            height: 2.8.h,
                                            width: 4.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                image: DecorationImage(image: AssetImage('assets/flags/${flagM.value}.png'), fit: BoxFit.cover)),
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 1.5.w,
                                      ),
                                      height: 2.5.h,
                                      width: 2.5.w,
                                      child: Image.asset(
                                        dropdown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8.sp,
                            ),
                            borderSide: const BorderSide(
                              color: CustomColor.btnBorder,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8.sp,
                            ),
                            borderSide: const BorderSide(
                              color: CustomColor.btnBorder,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8.sp,
                            ),
                            borderSide: const BorderSide(
                              color: CustomColor.btnBorder,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8.sp,
                            ),
                            borderSide: const BorderSide(
                              color: CustomColor.btnBorder,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  if (valKey.currentState != null) {
                    if (valKey.currentState!.validate()) {
                      onTapMethod();
                    } else {
                      print("error");
                    }
                  }
                },
                child: Container(
                  height: 5.h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: CustomColor.btn,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  child: CustomWidgets.text(
                    "Done",
                    fontWeight: FontWeight.w600,
                    color: CustomColor.white,
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

_showDialogOnButtonPressing(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 30.w,
          height: 50.h,
          child: Dialog(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // setState(() {
                  contryCodeM.value = countries[index].dialCode;
                  // });

                  mobileController.text = "${mobileController.text.split(" ").last} ";
                  numberLenghtM.value = countries[index].maxLength.toString();
                  flagM.value = countries[index].code.toLowerCase();
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Container(
                    height: 4.5.h,
                    width: 7.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(image: AssetImage('assets/flags/${countries[index].code.toLowerCase()}.png'), fit: BoxFit.cover)),
                  ),
                  title: CustomWidgets.text(
                    countries[index].name,
                  ),
                  subtitle: CustomWidgets.text(
                    countries[index].dialCode,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
