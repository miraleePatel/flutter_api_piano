// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:piano_project/Controller/authetication_controller.dart';
import 'package:piano_project/Utils/constant_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/app_color.dart';
import '../../Utils/string_constants.dart';
import '../../Widget/custom_button.dart';
import '../../Widget/custom_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthController authController = Get.put(AuthController());
  String? email = Get.arguments[0];
  String? screenName = Get.arguments[1];

  @override
  void initState() {
    if (kDebugMode) {
      print(email.toString());
    }
    authController.sendOTP(email: email.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    authController.otpController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: CustomColor.btnAbout,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    authBackgroundImage,
                  ),
                  Center(
                    child: Form(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24.h,
                          ),
                          CustomWidgets.text(
                            'Enter the 4 digit code that we sent you \n on your Email.',
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CustomWidgets.text(
                            'Code is sent to $email',
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            color: CustomColor.textDate,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                            ),
                            child: PinCodeTextField(
                              showCursor: false,
                              autoDisposeControllers: false,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              appContext: context,
                              length: 4,
                              enableActiveFill: true,
                              pinTheme: PinTheme(
                                selectedColor: CustomColor.btn,
                                inactiveColor: CustomColor.btnBorder,
                                activeColor: CustomColor.btn,
                                activeFillColor: CustomColor.btnCont,
                                selectedFillColor: CustomColor.btnCont,
                                inactiveFillColor: CustomColor.btnCont,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(13),
                                borderWidth: 1,
                                fieldHeight: 7.h,
                                fieldWidth: 7.h,
                              ),
                              cursorColor: CustomColor.black,
                              controller: authController.otpController,
                              keyboardType: TextInputType.number,
                              onCompleted: (v) {
                                debugPrint("Completed");
                              },
                              onChanged: (value) {},
                              beforeTextPaste: (text) {
                                debugPrint("Allowing to paste $text");
                                return true;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomWidgets.text(
                            'Didn’t receive code?',
                            fontWeight: FontWeight.w500,
                            color: CustomColor.textDate,
                            fontSize: 11.sp,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),

                          //resend otp
                          GestureDetector(
                            onTap: () {
                              authController.sendOTP(email: email.toString());
                            },
                            child: CustomWidgets.text(
                              'Request again',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),

                          //verify otp
                          CustomButton(
                            width: 80.w,
                            onPressed: () {
                              print(screenName.toString());
                              print("token");
                              print(getAuthToken());
                              if (authController.otpController.text != "") {
                                authController.verifyOTP(otp: authController.otpController.text, screenName: screenName.toString(), context: context);
                              } else {
                                errorSnackBar(title: "Error", message: "Please enter OTP");
                                authController.otpController.clear();
                              }
                            },
                            text: 'Submit',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
