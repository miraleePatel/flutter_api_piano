import 'dart:io';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(
    AuthController(),
  );
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final storage = GetStorage();
  String? screenName = Get.arguments;

  @override
  void initState() {
    authController.clearRigesterData();
    // authController.getUser(isLoaderShow: false);
    // bool isEmpty = GetStorage().read(userData) != null;

    // if (isEmpty) {
    //   print("if.........${isEmpty}");
    //   authController.checkLoginUser(
    //       email: LoginSuccessModel.fromJson(
    //         GetStorage().read(
    //           userData,
    //         ),
    //       ).data!.email.toString());
    // }
    super.initState();
  }

  @override
  void dispose() {
    authController.emailLoginController.clear();
    authController.passLoginController.clear();
    // authController.clearRigesterData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: CustomColor.btnAbout,
            body: GestureDetector(
              child: SingleChildScrollView(
                child: Form(
                  key: loginKey,
                  child: Stack(
                    children: [
                      Image.asset(
                        authBackgroundImage,
                      ),
                      Column(
                        children: [
                          CustomWidgets.CustAppbar(title: ''),
                          Column(
                            children: [
                              SizedBox(
                                height: 25.h,
                              ),
                              SizedBox(
                                width: 80.w,
                                child: CustomTextFiled(
                                  controller: authController.emailLoginController,
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
                                  hintText: 'Enter Email',
                                  image: Image.asset(
                                    email,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              SizedBox(
                                width: 80.w,
                                child: CustomTextFiled(
                                  controller: authController.passLoginController,
                                  validator: (value) {
                                    if (value!.trim() == "") {
                                      authController.passLoginController.clear();
                                      return 'Please Enter Password';
                                    } else if (value.length < 6) {
                                      return 'Password length Must be 6';
                                    }
                                    return null;
                                  },
                                  hintText: 'Enter Password',
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  image: Image.asset(
                                    lock,
                                  ),
                                ),
                              ),

                              //naviget forgot password screen
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0.5.h,
                                  left: 50.w,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.offNamed(Routes.FORGOT_PASSWORD_SCREEN, arguments: [false, screenName]);
                                    authController.forgotController.clear();
                                  },
                                  child: CustomWidgets.text(
                                    'Forgot Password?',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),

                              //call login api
                              CustomButton(
                                width: 80.w,
                                onPressed: () {
                                  if (loginKey.currentState!.validate()) {
                                    storage.write(
                                      "isLogin",
                                      true,
                                    );
                                    authController.signInWithEmailPassword(
                                      screenName: screenName.toString(),
                                      context: context,
                                    );
                                  }
                                },
                                text: 'LOGIN',
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15.w,
                                    color: CustomColor.divider,
                                    height: 0.1.h,
                                  ),
                                  CustomWidgets.text(
                                    '\t\tOr use your email account\t\t',
                                  ),
                                  Container(
                                    width: 15.w,
                                    color: CustomColor.divider,
                                    height: 0.1.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              //social login & ragister
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Platform.isIOS
                                      ? SizedBox(
                                          width: 5.w,
                                        )
                                      : Container(),
                                  //apple login & ragister
                                  Platform.isIOS
                                      ? CustomWidgets.LoginContainer(
                                          onPressed: () async {
                                            authController.appleApiCall(context: context, screenName: screenName.toString());
                                          },
                                          image: Image.asset(
                                            appleLogo,
                                          ),
                                          color: CustomColor.black,
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  //google login & ragister
                                  CustomWidgets.LoginContainer(
                                    onPressed: () async {
                                      authController.signUpWithGoogle(
                                        context: context,
                                        screenName: screenName.toString(),
                                      );
                                    },
                                    image: Image.asset(
                                      googleLogo,
                                    ),
                                    color: CustomColor.btn,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),

                              //naviget ragistration screen
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomWidgets.text(
                                    "Don't have an account?\t\t",
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.offNamed(
                                        Routes.REGISTRATION_SCREEN,
                                        arguments: screenName,
                                      );
                                      authController.passLoginController.clear();
                                      authController.emailLoginController.clear();
                                    },
                                    child: CustomWidgets.text(
                                      'Register here',
                                      color: CustomColor.textHere,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
