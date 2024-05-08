import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import '../../../Controller/authetication_controller.dart';
import '../../../Data/Model/login_response_model.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/constant_widgets.dart';
import '../../../Utils/string_constants.dart';
import '../../../Widget/custom_button.dart';
import '../../../Widget/custom_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    // authController.getUser(isLoaderShow: false);
    bool isEmpty = GetStorage().read(userData) != null;

    if (isEmpty) {
      if (kDebugMode) {
        print("if.........$isEmpty");
      }
      authController.checkLoginUser(
          email: LoginSuccessModel.fromJson(
        GetStorage().read(
          userData,
        ),
      ).data!.email.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: CustomColor.btnAbout,
          body: RefreshIndicator(
            color: CustomColor.btn,
            onRefresh: () async {
              // authController.userDataList.clear();
              // authController.getUser(isLoaderShow: true);
              bool isEmpty = GetStorage().read(userData) != null;

              if (isEmpty) {
                if (kDebugMode) {
                  print("if.........$isEmpty");
                }
                authController.checkLoginUser(
                    email: LoginSuccessModel.fromJson(
                  GetStorage().read(
                    userData,
                  ),
                ).data!.email.toString());
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Stack(
                children: [
                  Image.asset(
                    backgroundImage,
                  ),

                  // no internet connection
                  Obx(
                    () {
                      return isInternetAvailable.value == true
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  CustomWidgets.text(
                                    "Menu",
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Image.asset(
                                    logo,
                                    scale: SizerUtil.deviceType == DeviceType.mobile ? 2.5 : 1.5,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),

                                  // User Detail
                                  Obx(
                                    () {
                                      return (authController.isLogin.value == true)
                                          //before login or ragister
                                          ? CustomWidgets.customContainer(
                                              margintop: 2.h,
                                              top: 5.5.h,
                                              height: 33.h,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 5.w,
                                                    top: 1.h,
                                                    bottom: 2.h,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            CustomWidgets.text(
                                                              "Name",
                                                              color: CustomColor.textBluerMenu,
                                                            ),
                                                            CustomWidgets.text(
                                                              authController.loginDetails.value.data!.fullName.toString(),
                                                              fontSize: 12.sp,
                                                              fontWeight: FontWeight.w700,
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            CustomWidgets.text(
                                                              "Email",
                                                              color: CustomColor.textBluerMenu,
                                                            ),
                                                            CustomWidgets.text(
                                                              authController.loginDetails.value.data!.email.toString(),
                                                              fontSize: 12.sp,
                                                              fontWeight: FontWeight.w700,
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            CustomWidgets.text(
                                                              "Mobile Number",
                                                              color: CustomColor.textBluerMenu,
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                              child: Obx(
                                                                () => Row(
                                                                  children: [
                                                                    (authController.loginDetails.value.data!.file.toString() != " " &&
                                                                            authController.loginDetails.value.data!.phoneNo != "null" &&
                                                                            authController.loginDetails.value.data!.phoneNo != null &&
                                                                            authController.loginDetails.value.data!.file != null)
                                                                        ? Container(
                                                                            height: 2.8.h,
                                                                            width: 4.h,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              image: DecorationImage(
                                                                                  image: NetworkImage(
                                                                                      '$imageUrl${authController.loginDetails.value.data!.file.toString()}'),
                                                                                  fit: BoxFit.cover),
                                                                            ))
                                                                        : Container(),
                                                                    authController.loginDetails.value.data!.phoneNo != "null" &&
                                                                            authController.loginDetails.value.data!.phoneNo != null &&
                                                                            authController.loginDetails.value.data!.phoneNo != "" &&
                                                                            authController.loginDetails.value.data!.phoneNo != null
                                                                        ? SizedBox(
                                                                            width: 2.w,
                                                                          )
                                                                        : const SizedBox(),
                                                                    authController.loginDetails.value.data!.phoneNo != "null" &&
                                                                            authController.loginDetails.value.data!.phoneNo != null &&
                                                                            authController.loginDetails.value.data!.countryCode != "null" &&
                                                                            authController.loginDetails.value.data!.countryCode != null
                                                                        ? CustomWidgets.text(
                                                                            "(${authController.loginDetails.value.data!.countryCode.toString()}) ${authController.loginDetails.value.data!.phoneNo!.split(" ").last.toString()}",
                                                                            fontSize: 12.sp,
                                                                            fontWeight: FontWeight.w700,
                                                                          )
                                                                        : CustomWidgets.text(
                                                                            "-",
                                                                            fontSize: 12.sp,
                                                                            fontWeight: FontWeight.w700,
                                                                          )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),

                                                        //update user detail
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              CustomWidgets.text(
                                                                "Update your details",
                                                                fontSize: 12.sp,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                              SizedBox(
                                                                width: 35.w,
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                  right: 1.w,
                                                                ),
                                                                width: 7.5.w,
                                                                height: 4.5.h,
                                                                decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                    image: AssetImage(
                                                                      menuBackIcon,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox()
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        //delete accoutn
                                                        CustomButton(
                                                          width: 79.w,
                                                          onPressed: () {
                                                            deleteAccountgAlert(
                                                                context: context,
                                                                onPressed: () async {
                                                                  // authController.userDataList.clear();
                                                                  if (authController.isLogin.value == true) {
                                                                    authController.logoutAPI(isDelete: "delete");
                                                                    await GoogleSignIn().signOut();
                                                                    authController.isLogin.value = false;
                                                                    Get.back();
                                                                  }
                                                                });
                                                          },
                                                          text: "Delete Account",
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            )
                                          //after login or ragister
                                          : CustomWidgets.customContainer(
                                              margintop: 2.h,
                                              top: 2.5.h,
                                              height: 10.h,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  left: 3.w,
                                                  top: 2.h,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CustomButton(
                                                      width: 83.w,
                                                      onPressed: () {
                                                        Get.toNamed(
                                                          Routes.LOGIN_SCREEN,
                                                          arguments: "editprofile",
                                                        );
                                                      },
                                                      text: 'LOGIN',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                    },
                                  ),

                                  // Help & Support
                                  CustomWidgets.customContainer(
                                    margintop: 2.h,
                                    top: 3.5.h,
                                    height: 13.h,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 4.w,
                                        top: 1.5.h,
                                        bottom: 1.h,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomWidgets.text(
                                              "Help & Support",
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w800,
                                              color: CustomColor.btn,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.FAQ_SCREEN,
                                                    );
                                                  },
                                                  child: CustomWidgets.text(
                                                    "Piano care guide",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                const Spacer(),
                                                CustomWidgets.customIcon(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.FAQ_SCREEN,
                                                    );
                                                  },
                                                ),
                                                const SizedBox()
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Package
                                  CustomWidgets.customContainer(
                                    margintop: 2.h,
                                    top: 3.5.h,
                                    height: 13.h,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 4.w,
                                        top: 1.5.h,
                                        bottom: 1.h,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomWidgets.text(
                                              "Wallet Balance",
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w800,
                                              color: CustomColor.btn,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    (authController.isLogin.value == true && authController.showLogout.value)
                                                        ? Get.toNamed(
                                                            Routes.WALLENT_BALANCE_SCREEN,
                                                          )
                                                        : Get.toNamed(
                                                            Routes.LOGIN_SCREEN,
                                                            arguments: "editprofile",
                                                          );
                                                  },
                                                  child: CustomWidgets.text(
                                                    "Remaining Hours",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                const Spacer(),
                                                CustomWidgets.customIcon(
                                                  onTap: () {
                                                    (getAuthToken() != "")
                                                        ? Get.toNamed(
                                                            Routes.WALLENT_BALANCE_SCREEN,
                                                          )
                                                        : Get.toNamed(
                                                            Routes.LOGIN_SCREEN,
                                                            arguments: "editprofile",
                                                          );
                                                  },
                                                ),
                                                const SizedBox()
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  //Company
                                  CustomWidgets.customContainer(
                                    margintop: 2.h,
                                    top: 4.h,
                                    height: 24.h,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 4.w,
                                        top: 1.5.h,
                                        bottom: 1.h,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomWidgets.text(
                                              "Company",
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w800,
                                              color: CustomColor.btn,
                                            ),

                                            //about us
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.ABOUT_SCREEN,
                                                    );
                                                  },
                                                  child: CustomWidgets.text(
                                                    "About Us",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                const Spacer(),
                                                CustomWidgets.customIcon(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.ABOUT_SCREEN,
                                                    );
                                                  },
                                                ),
                                                const SizedBox()
                                              ],
                                            ),
                                            //contact us
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.CONTACT_SCREEN,
                                                    );
                                                  },
                                                  child: CustomWidgets.text(
                                                    "Contact Us",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                const Spacer(),
                                                CustomWidgets.customIcon(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.CONTACT_SCREEN,
                                                    );
                                                  },
                                                ),
                                                const SizedBox(),
                                              ],
                                            ),
                                            //terms & condiyion
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.TERMS_CONDITIONS_SCREEN,
                                                    );
                                                  },
                                                  child: CustomWidgets.text(
                                                    "Terms & Conditions",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                const Spacer(),
                                                CustomWidgets.customIcon(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.TERMS_CONDITIONS_SCREEN,
                                                    );
                                                  },
                                                ),
                                                const SizedBox(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              ),
                            )
                          : CustomWidgets.NoInertnet(top: 20);
                    },
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

deleteAccountgAlert({required BuildContext context, void Function()? onPressed}) {
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
          title: CustomWidgets.text('Delete Account'),
          content: CustomWidgets.text('Are you sure want to delete account?', fontSize: 13.sp),
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
