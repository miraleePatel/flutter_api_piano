// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, unused_import, unnecessary_overrides, avoid_print, unnecessary_null_comparison, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:piano_project/Controller/welcome_controller.dart';
import 'package:piano_project/Data/Model/current_user_model.dart';
import 'package:piano_project/Data/Model/logout_model.dart';
import 'package:piano_project/Utils/app_color.dart';
import 'package:piano_project/Widget/custom_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sizer/sizer.dart';
import '../Data/Api/api_manager.dart';
import '../Data/Api/post_api_manager.dart';
import '../Data/Model/login_response_model.dart';
import '../Data/Model/otp_model.dart';
import '../Data/Model/send_mail_model.dart';
import '../Repository/authentication_repository.dart';
import '../Routes/routes.dart';
import '../Utils/constant_widgets.dart';
import '../Utils/string_constants.dart';
import '../Widget/custom_mobile_dialog.dart';
import '../Widget/custom_widget.dart';

class AuthController extends GetxController {
  final authenticationRepository = AuthenticationRepository(APIManager(), PostAPIManager());

  //********************** TextEditingController **********************//

  // Login Screen

  TextEditingController passLoginController = TextEditingController(text: "");
  TextEditingController emailLoginController = TextEditingController(text: "");

  // Registration Screen

  TextEditingController passController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController phController = TextEditingController(text: "");
  TextEditingController tempEmailController = TextEditingController();

  // OTP Screen

  TextEditingController otpController = TextEditingController();

  // Forgot Password Screen

  TextEditingController forgotController = TextEditingController(text: "");

  //********************** variable declaration **********************//

  RxString flag = 'ae'.obs;
  RxString numberLenght = '9'.obs;
  RxString contryCode = '+971'.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<LoginSuccessModel> loginDetails = LoginSuccessModel().obs;
  RxBool showLogout = true.obs;
  RxBool isGoogleReg = false.obs;
  RxBool isAppleReg = false.obs;
  RxInt userRoleGroup = 1.obs;
  RxString userRole = 'user'.obs;

  Rx<CurrentUserModel> currentUser = CurrentUserModel().obs;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  RxString fcmToken = "".obs;
  RxBool agree = false.obs;
  RxBool isLogin = false.obs;
  var mobilenumber = "".obs;

//********************** onInit Method **********************//

  @override
  void onInit() async {
    getFcmToken();
    super.onInit();
  }

//*********************** for getFcmTokem *********************//

  getFcmToken() async {
    var getToken = await FirebaseMessaging.instance.getToken();
    fcmToken.value = getToken!;
    if (kDebugMode) {
      print("[FCM Token] =====> $fcmToken");
    }
  }

//********************** clear Rigester Data **********************//

  clearRigesterData() {
    numberLenght.value = '9';
    contryCode.value = '+971';
    flag.value = "ae";
    nameController.clear();
    emailController.clear();
    passController.clear();
    phController.clear();
  }

//********************** Logout/SignOut API Call **********************//

  Future logoutAPI({String? isDelete}) async {
    LogoutModel res = await authenticationRepository.logoutAPICall();

    showLogout.value = false;

    // success message & erase store

    if (res.status == 1) {
      await GetStorage().erase();
      auth.signOut();
      if (isDelete == "delete") {
        successSnackBar(message: "Delete Account Successfully");
      } else {
        successSnackBar(message: res.message);
      }
    }
  }

//********************** sendMail API Call **********************//

  sendMailApi({required String email, required String screenName}) async {
    SendMailModel res = await authenticationRepository.sendMailAPICall(email: email);

    // success message & navigation

    if (res.status == 1) {
      successSnackBar(message: res.message);
      Get.offNamed(Routes.LOGIN_SCREEN, arguments: screenName);
    } else {
      errorSnackBar(message: res.message);
    }
  }

  //********************** sign in with E-mail & Password **********************//

  signInWithEmailPassword({required String screenName, required BuildContext context}) async {
    loginDetails.value = await authenticationRepository.loginApiCall(
      email: emailLoginController.text.trim(),
      password: passLoginController.text.trim(),
      fcmToken: fcmToken.value,
    );

    // success message & navigation

    if (loginDetails.value.status == 1) {
      GetStorage().write(userData, loginDetails.toJson());
      storeAuthToken(loginDetails.value.token.toString());
      storeVerifyStatus(loginDetails.value.data!.emailVerified!);
      storeUserRole(loginDetails.value.data!.role!);
      showLogout.value = true;
      if (screenName == "booking") {
        Get.offNamed(Routes.BOOKING_SCREEN);
      } else if (screenName == "editprofile") {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      } else if (screenName == "forgotpassword") {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      } else if (screenName == "Pianoteacher") {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      } else {
        // Get.back(closeOverlays: true);

        Navigator.of(context).pop();
      }
      successSnackBar(message: loginDetails.value.message);
    } else if (loginDetails.value.status == 2) {
      errorSnackBar(message: loginDetails.value.message);
      storeAuthToken(loginDetails.value.token.toString());
      print("token.....");
      print(GetStorage().read(authToken));
      Get.toNamed(Routes.FORGOT_PASSWORD_SCREEN, arguments: [true, screenName]);
    } else {
      errorSnackBar(message: loginDetails.value.message);
    }

    update();
  }

//********************** sign up with E-mail & Password **********************//

  signUpWithEmailPassword({required String screenName, required String role, required BuildContext context}) async {
    loginDetails.value = await authenticationRepository.registerApiCall(
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        countryCode: contryCode.value,
        phoneNo: phController.text,
        password: passController.text.trim(),
        file: "${flag.value}.png",
        fcmToken: fcmToken.value,
        // file: 'assets/flags/dubai.png',
        role: role);

    if (loginDetails.value.status == 1) {
      // store auth token

      storeAuthToken(loginDetails.value.token.toString());
      storeVerifyStatus(loginDetails.value.data!.emailVerified!);
      storeUserRole(loginDetails.value.data!.role!);
      // success message & navigation

      GetStorage().write(userData, loginDetails.toJson());
      showLogout.value = true;
      Get.toNamed(Routes.OTP_SCREEN, arguments: [loginDetails.value.data!.email!, screenName]);
    } else {
      errorSnackBar(message: loginDetails.value.message);
    }
  }

  sendOTP({required String email}) async {
    OtpModel res = await authenticationRepository.sendOTPAPICall(
      email: email,
    );

    if (res.status == 1) {
      successSnackBar(message: res.message);
    } else {
      errorSnackBar(message: res.message);
    }
  }

  verifyOTP({required String otp, required String screenName, required BuildContext context}) async {
    loginDetails.value = await authenticationRepository.verifyOTPAPICall(otp: otp);
    if (loginDetails.value.status == 1) {
      storeVerifyStatus(loginDetails.value.data!.emailVerified!);
      storeUserRole(loginDetails.value.data!.role!);
      if (screenName == "booking") {
        Get.offNamed(Routes.BOOKING_SCREEN);
      } else if (screenName == "editprofile") {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      } else if (screenName == "forgotpassword") {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      } else if (screenName == "Pianoteacher") {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        // Get.back(result: true, closeOverlays: true);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
      }
      successSnackBar(message: 'Create account successfully');
    } else {
      errorSnackBar(message: loginDetails.value.message);
    }
  }

  //*********************** current user *********************//
  //********************** Google login **********************//
  checkLoginUser({required String email}) async {
    loginDetails.value = await authenticationRepository.loginUserApiCall(email: email);
    if (loginDetails.value.status == 1) {
      GetStorage().write(userData, loginDetails.toJson());
      storeVerifyStatus(loginDetails.value.data!.emailVerified!);
      storeUserRole(loginDetails.value.data!.role!);
      isLogin.value = true;
    } else {
      GetStorage().write(userData, loginDetails.toJson());
      storeVerifyStatus(loginDetails.value.data!.emailVerified!);
      storeUserRole(loginDetails.value.data!.role!);
      isLogin.value = false;
    }
  }

  signUpWithGoogle({required BuildContext context, required String screenName}) async {
    // Show progress loader
    showProgressIndicator();

    try {
      UserCredential userCredential;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      userCredential = await auth.signInWithCredential(googleAuthCredential);
      User? user = userCredential.user;

      if (user != null) {
        currentUser.value = await authenticationRepository.currentUserApiCall(email: user.email!);
        if (currentUser.value.status == 0) {
          print("hello");
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: CustomColor.btnBCon,
                scrollable: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                actionsPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomWidgets.text(
                      "Are you a Music Teacher??",
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () async {
                        Get.back(closeOverlays: true);
                        await GoogleSignIn().signOut();
                      },
                    ),
                  ],
                ),
                actions: [
                  InkWell(
                    onTap: () async {
                      clearMobileDialog();
                      addMobileDialog(context, onTapMethod: () async {
                        loginDetails.value = await authenticationRepository.socialRegisterApiCall(
                            fullName: user.displayName!.trim(),
                            email: user.email!,
                            phoneNo: mobileController.text,
                            password: "",
                            file: "${flagM.value}.png",
                            countryCode: contryCodeM.value,
                            socialMedia: "google",
                            fcmToken: fcmToken.value,
                            role: userRole.value);
                        showLogout.value = true;

                        if (loginDetails.value.status == 1) {
                          print("status 1 ");
                          print(":::::::::::${loginDetails.value.status}");
                          GetStorage().write(userData, loginDetails.value.toJson());
                          storeAuthToken(loginDetails.value.token!);
                          storeVerifyStatus(loginDetails.value.data!.emailVerified!);
                          storeUserRole(loginDetails.value.data!.role!);
                          isGoogleReg.value = true;
                          print("isGoogleReg.value .........................");
                          print(isGoogleReg.value);
                          // successSnackBar(message: loginDetails.value.message);
                        }
                        if (screenName == "booking") {
                          Get.offNamed(Routes.BOOKING_SCREEN);
                        } else if (screenName == "editprofile") {
                          Timer(const Duration(milliseconds: 500), () {
                            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                          });
                        } else if (screenName == "forgotpassword") {
                          Timer(const Duration(milliseconds: 500), () {
                            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                          });
                        } else if (screenName == "Pianoteacher") {
                          Timer(const Duration(milliseconds: 500), () {
                            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                          });
                        } else if (screenName == "packageScreen") {
                          Get.back(result: true, closeOverlays: true);
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }

                        loginDetails.value.status == 1 ? successSnackBar(message: loginDetails.value.message) : "";
                      });
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
                        "OK",
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
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Obx(
                          () => ListTile(
                            title: const Text('Yes'),
                            leading: Radio(
                              activeColor: CustomColor.btn,
                              value: 0,
                              groupValue: userRoleGroup.value,
                              onChanged: (value) {
                                userRoleGroup.value = value!;
                                userRole.value = "teacher";
                                informationSnackBar(message: "This is subject to verify by House of Pianos");
                              },
                            ),
                          ),
                        ),
                        Obx(
                          () => ListTile(
                            title: const Text('No'),
                            leading: Radio(
                              activeColor: CustomColor.btn,
                              groupValue: userRoleGroup.value,
                              onChanged: (value) {
                                userRoleGroup.value = value!;
                                userRole.value = "user";
                              },
                              value: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          loginDetails.value = await authenticationRepository.loginUserApiCall(email: user.email!);
          if (loginDetails.value.data!.phoneNo == null ||
              loginDetails.value.data!.phoneNo == "null" ||
              loginDetails.value.data!.phoneNo == "" ||
              loginDetails.value.data!.countryCode == null ||
              loginDetails.value.data!.file == null) {
            clearMobileDialog();
            await addMobileDialog(context, onTapMethod: () async {
              signInWithSocial({
                "fullName": user.displayName!.trim(),
                "email": user.email!,
                "phone_no": mobileController.text,
                "file": "${flagM.value}.png",
                "country_code": contryCodeM.value,
                "social_media": "google",
                "fcmToken": fcmToken.value
              }, user: user, screenName: screenName, context: context);
              isLogin.value = true;
            });
          } else {
            signInWithSocial({
              "fullName": user.displayName!.trim(),
              "email": user.email!,
              "phone_no": loginDetails.value.data!.phoneNo,
              "file": loginDetails.value.data!.file,
              "country_code": loginDetails.value.data!.countryCode,
              "social_media": "google",
              "fcmToken": fcmToken.value
            }, user: user, screenName: screenName, context: context);
            isLogin.value = true;
          }

          // loginDetails.value.status == 1 ? successSnackBar(message: loginDetails.value.message) : "";
        }
      }
    } catch (error) {
      print(error);
    } finally {
      // Hide progress loader
      dismissProgressIndicator();
    }
  }
//********************** Google login **********************//

// SignIn with Google

  signInWithSocial(Map<String, dynamic> params, {required BuildContext context, required User user, required String screenName}) async {
    loginDetails.value = await authenticationRepository.socialLoginApiCall(params);

    GetStorage().write(userData, loginDetails.value.toJson());
    showLogout.value = true;

    // store auth token

    storeAuthToken(loginDetails.value.token!);
    storeVerifyStatus(loginDetails.value.data!.emailVerified!);
    storeUserRole(loginDetails.value.data!.role!);
    checkLoginUser(email: user.email.toString());

    if (screenName == "booking") {
      Get.offNamed(Routes.BOOKING_SCREEN);
    } else if (screenName == "editprofile") {
      Timer(const Duration(milliseconds: 500), () {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      });
    } else if (screenName == "forgotpassword") {
      Timer(const Duration(milliseconds: 500), () {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      });
    } else if (screenName == "Pianoteacher") {
      Timer(const Duration(milliseconds: 500), () {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      });
    } else if (screenName == "packageScreen") {
      Get.back(result: true, closeOverlays: true);
    } else {
      Navigator.of(context).pop();
    }
    // success message
    successSnackBar(message: loginDetails.value.message);
  }

//********************** Apple login **********************//

  late FirebaseAuth firebaseAuth;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  // Returns the sha256 hash of [input] in hex notation.

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Apple Authetication

  appleApiCall({required BuildContext context, required String screenName}) async {
    // Show progress loader
    showProgressIndicator();

    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      UserCredential userCredential;
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      User? user = userCredential.user;
      print("User data ::::::: ${user}");

      if (user != null && appleCredential.givenName != null && appleCredential.familyName != null) {
        currentUser.value = await authenticationRepository.currentUserApiCall(email: user.email!);
        if (currentUser.value.status == 0) {
          print("hello");
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: CustomColor.btnBCon,
                scrollable: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                actionsPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomWidgets.text(
                      "Are you a Music Teacher??",
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        Get.back(closeOverlays: true);
                      },
                    ),
                  ],
                ),
                actions: [
                  InkWell(
                    onTap: () async {
                      clearMobileDialog();
                      addMobileDialog(context, onTapMethod: () async {
                        print(appleCredential.familyName);
                        print("Apple data ::::::: ${appleCredential.givenName}");
                        print("Apple data ::::::: ${appleCredential.familyName}");
                        loginDetails.value = await authenticationRepository.socialRegisterApiCall(
                            fullName: "${appleCredential.givenName} ${appleCredential.familyName}",
                            email: user.email ?? "",
                            phoneNo: mobileController.text,
                            password: "",
                            file: "${flagM.value}.png",
                            countryCode: contryCodeM.value,
                            socialMedia: "apple",
                            fcmToken: fcmToken.value,
                            role: userRole.value);
                        // store auth token
                        if (loginDetails.value.status == 1) {
                          print(":::::::::::${loginDetails.value.status}");
                          GetStorage().write(userData, loginDetails.value.toJson());
                          storeAuthToken(loginDetails.value.token!);
                          storeVerifyStatus(loginDetails.value.data!.emailVerified!);
                          storeUserRole(loginDetails.value.data!.role!);
                          isAppleReg.value = true;
                          // successSnackBar(message: loginDetails.value.message);
                        }
                        showLogout.value = true;

                        if (screenName == "booking") {
                          Get.offNamed(Routes.BOOKING_SCREEN);
                        } else if (screenName == "editprofile") {
                          Timer(const Duration(milliseconds: 500), () {
                            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                          });
                        } else if (screenName == "forgotpassword") {
                          Timer(const Duration(milliseconds: 500), () {
                            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                          });
                        } else if (screenName == "Pianoteacher") {
                          Timer(const Duration(milliseconds: 500), () {
                            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                          });
                        } else if (screenName == "packageScreen") {
                          Get.back(result: true, closeOverlays: true);
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                        successSnackBar(message: loginDetails.value.message);
                      });
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
                        "OK",
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
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Obx(
                          () => ListTile(
                            title: const Text('Yes'),
                            leading: Radio(
                              activeColor: CustomColor.btn,
                              value: 0,
                              groupValue: userRoleGroup.value,
                              onChanged: (value) {
                                userRoleGroup.value = value!;
                                userRole.value = "teacher";
                                informationSnackBar(message: "This is subject to verify by House of Pianos");
                              },
                            ),
                          ),
                        ),
                        Obx(
                          () => ListTile(
                            title: const Text('No'),
                            leading: Radio(
                              activeColor: CustomColor.btn,
                              groupValue: userRoleGroup.value,
                              onChanged: (value) {
                                userRoleGroup.value = value!;
                                userRole.value = "user";
                              },
                              value: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          print("Apple data ::::::: ${appleCredential.givenName}");
          print("Apple data ::::::: ${appleCredential.familyName}");
          // SignIn API Call
          loginDetails.value = await authenticationRepository.loginUserApiCall(email: user.email!);
          if (loginDetails.value.data!.phoneNo == null ||
              loginDetails.value.data!.phoneNo == "null" ||
              loginDetails.value.data!.phoneNo == "" ||
              loginDetails.value.data!.countryCode == null ||
              loginDetails.value.data!.file == null) {
            clearMobileDialog();
            addMobileDialog(context, onTapMethod: () async {
              signInWithSocial({
                "fullName": user.displayName!.trim(),
                "email": user.email!,
                "phone_no": mobileController.text,
                "file": "${flagM.value}.png",
                "country_code": contryCodeM.value,
                "social_media": "apple",
                "fcmToken": fcmToken.value
              }, user: user, screenName: screenName, context: context);
            });
          } else {
            signInWithSocial({
              "fullName": user.displayName!.trim(),
              "email": user.email!,
              "phone_no": loginDetails.value.data!.phoneNo,
              "file": loginDetails.value.data!.file,
              "countryCode": loginDetails.value.data!.countryCode,
              "social_media": "apple",
              "fcmToken": fcmToken.value
            }, user: user, screenName: screenName, context: context);
          }

          showLogout.value = true;
        }
      } else {
        print("Apple data ::::::: ${appleCredential.givenName}");
        print("Apple data ::::::: ${appleCredential.familyName}");
        // SignIn API Call
        loginDetails.value = await authenticationRepository.loginUserApiCall(email: user!.email!);
        if (loginDetails.value.data!.phoneNo == null ||
            loginDetails.value.data!.phoneNo == "null" ||
            loginDetails.value.data!.phoneNo == "" ||
            loginDetails.value.data!.countryCode == null ||
            loginDetails.value.data!.file == null) {
          clearMobileDialog();
          addMobileDialog(context, onTapMethod: () async {
            signInWithSocial({
              "fullName": user.displayName.toString(),
              "email": user.email!,
              "phone_no": mobileController.text,
              "file": "${flagM.value}.png",
              "country_code": contryCodeM.value,
              "social_media": "apple",
              "fcmToken": fcmToken.value
            }, user: user, screenName: screenName, context: context);
          });
        } else {
          signInWithSocial({
            "fullName": user.displayName.toString(),
            "email": user.email!,
            "phone_no": loginDetails.value.data!.phoneNo,
            "file": loginDetails.value.data!.file,
            "country_code": loginDetails.value.data!.countryCode,
            "social_media": "apple",
            "fcmToken": fcmToken.value
          }, user: user, screenName: screenName, context: context);
        }
        // showLogout.value = true;
      }
    } catch (error) {
      print(error);
    } finally {
      // Hide progress loader
      dismissProgressIndicator();
    }
  }

//********************** Store User Auth Toke **********************//

  storeAuthToken(String token) {
    GetStorage().write(authToken, token);
  }

  storeVerifyStatus(bool isEmail) {
    GetStorage().write(isVerifyEmail, isEmail);
  }

  storeUserRole(String role) {
    GetStorage().write(isuserRole, role);
  }
}
