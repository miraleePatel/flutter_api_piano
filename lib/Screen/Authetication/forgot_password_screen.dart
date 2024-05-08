// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/authetication_controller.dart';
import '../../Utils/app_color.dart';
import '../../Utils/string_constants.dart';
import '../../Routes/routes.dart';
import '../../Widget/custom_button.dart';
import '../../Widget/custom_textfield.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final AuthController authController = Get.put(
    AuthController(),
  );
  GlobalKey<FormState> forgotKey = GlobalKey<FormState>();
  bool? isOtpVerify = Get.arguments[0];
  String? screenName = Get.arguments[1];


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

                  Obx(() =>  isInternetAvailable.value == true?
                  Center(
                    child: Form(
                      key: forgotKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          SizedBox(
                            width: 80.w,
                            child: CustomTextFiled(
                              controller: authController.forgotController,
                              validator: (value) {
                                RegExp emailRegExp = RegExp(
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
                                if (value!.isEmpty) {
                                  return 'Please Enter Your Email';
                                } else if (!emailRegExp.hasMatch(value)) {
                                  return 'Enter Valid Email Address';
                                }
                                return null;
                              },
                              hintText: 'Enter Email Address',
                              image: Image.asset(
                                email,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),

                          // Back to login screen
                          GestureDetector(
                            onTap: () {
                              Get.offNamed(Routes.LOGIN_SCREEN,
                                  arguments: "forgotpassword");
                              authController.forgotController.clear();
                            },
                            child: CustomWidgets.text(
                              'Back to sign in',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),

                          // navigation & api calling
                          CustomButton(
                            width: 80.w,
                            onPressed: () {
                              if (forgotKey.currentState!.validate()) {
                                if(isOtpVerify == true){
                                  print("token.....");
                                  print(GetStorage().read(authToken));
                                  Get.offNamed(Routes.OTP_SCREEN, arguments:[authController.forgotController.text,screenName.toString()]);
                                }else{
                                  authController.sendMailApi(
                                    email: authController.forgotController.text,screenName: screenName.toString()
                                  );
                                  authController.forgotController.clear();}
                              }
                            },
                            text: 'SEND',
                          ),
                        ],
                      ),
                    ),
                  ) : CustomWidgets.NoInertnet(top: 250))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
