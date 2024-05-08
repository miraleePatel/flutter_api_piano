// ignore_for_file: prefer_is_empty, unrelated_type_equality_checks, unnecessary_string_escapes, unused_element, avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Utils/constant_widgets.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/authetication_controller.dart';
import '../../Routes/routes.dart';
import '../../Utils/app_color.dart';
import '../../Utils/country_list.dart';
import '../../Utils/string_constants.dart';
import '../../Widget/custom_button.dart';
import '../../Widget/custom_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AuthController authController = Get.put(
    AuthController(),
  );

  bool checkedValue = false;
  String? screenName = Get.arguments;
  final storage = GetStorage();
  GlobalKey<FormState> regKey = GlobalKey<FormState>();

  @override
  void initState() {
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
    authController.agree.value = false;
    super.initState();
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: CustomColor.btnAbout,
            body: SingleChildScrollView(
              child: Form(
                key: regKey,
                child: Stack(
                  children: [
                    Image.asset(
                      authBackgroundImage,
                    ),
                    Obx(() {
                      return Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 25.h,
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: CustomTextFiled(
                                    controller: authController.nameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Your Name';
                                      } else if (value.length < 3) {
                                        return 'Please enter the minimum 3 latter';
                                      }
                                      return null;
                                    },
                                    hintText: 'Enter Your Full Name',
                                    image: Image.asset(
                                      person,
                                    ),
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: CustomTextFiled(
                                    controller: authController.emailController,
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
                                  height: 1.5.h,
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: TextFormField(
                                    controller: authController.phController,
                                    validator: (value) {
                                      if (authController.numberLenght != authController.phController.text.split(" ").last.length.toString()) {
                                        return 'Phone Number length Must be ${authController.numberLenght.value}';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[' '\+\0-9\.]")),
                                    ],
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
                                          CustomWidgets.text("${authController.contryCode.value} ", fontSize: 13.sp),
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
                                                            image: DecorationImage(
                                                                image: AssetImage('assets/flags/${authController.flag.value}.png'),
                                                                fit: BoxFit.cover)),
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
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: CustomTextFiled(
                                    controller: authController.passController,
                                    validator: (value) {
                                      if (value!.trim() == "") {
                                        authController.passController.clear();
                                        return 'Please Enter Password';
                                      } else if (value.length < 6) {
                                        return 'Password length Must be 6';
                                      }
                                      return null;
                                    },
                                    hintText: 'Enter Password',
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    image: Image.asset(lock),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Checkbox(
                                        activeColor: CustomColor.btn,
                                        value: authController.agree.value,
                                        onChanged: (value) {
                                          authController.agree.value = !authController.agree.value;
                                          if (authController.agree.value == true) {
                                            informationSnackBar(message: 'This is subject to verify by House of Pianos');
                                          }
                                        },
                                      ),
                                      Expanded(
                                        child: CustomWidgets.text('Are you a Music Teacher ?',
                                            overflow: TextOverflow.ellipsis, maxLine: 2, fontWeight: FontWeight.w800, fontSize: 10.sp),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7.5.h,
                                ),

                                //call register api
                                CustomButton(
                                  width: 80.w,
                                  onPressed: () {
                                    if (regKey.currentState!.validate()) {
                                      authController.signUpWithEmailPassword(
                                          screenName: screenName.toString(),
                                          context: context,
                                          role: authController.agree.value == true ? 'teacher' : 'user');
                                    }
                                  },
                                  text: 'REGISTER',
                                ),
                                SizedBox(
                                  height: 5.h,
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
                                  height: 4.h,
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
                                            onPressed: () {
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
                                      image: Image.asset(googleLogo),
                                      color: CustomColor.btn,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.5.h,
                                ),
                                //neviget login screen
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomWidgets.text(
                                      'Already have an account?\t\t',
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        authController.nameController.clear();
                                        authController.emailController.clear();
                                        authController.passController.clear();

                                        Get.offNamed(
                                          Routes.LOGIN_SCREEN,
                                          arguments: screenName,
                                        );
                                      },
                                      child: CustomWidgets.text(
                                        'Login here',
                                        color: CustomColor.textHere,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //country picker

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
                    setState(() {
                      authController.contryCode.value = countries[index].dialCode;
                    });
                    authController.phController.text = "${authController.phController.text.split(" ").last} ";
                    authController.numberLenght.value = countries[index].maxLength.toString();
                    authController.flag.value = countries[index].code.toLowerCase();
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
}
