import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Controller/authetication_controller.dart';
import 'package:piano_project/Utils/app_color.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:sizer/sizer.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Widget/custom_widget.dart';

class FindPianoTeacher extends StatefulWidget {
  const FindPianoTeacher({Key? key}) : super(key: key);

  @override
  State<FindPianoTeacher> createState() => _FindPianoTeacherState();
}

class _FindPianoTeacherState extends State<FindPianoTeacher> {
  final AuthController authController = Get.find();
  bool isCheck = getVerifyStatus();
  String token = getAuthToken();

  @override
  void initState() {
    super.initState();
    // authController.getUser(isLoaderShow: false);
    bool isEmpty = GetStorage().read(userData) != null;

    if (isEmpty == true) {
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColor.btnAbout,
            body: Container(
              height: 96.85.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    pianoTeach,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      CustomWidgets.CustAppbar(title: "Find Piano Teacher"),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Obx(
                              () {
                                return (authController.isLogin.value == true)
                                    ? GestureDetector(
                                        child: Container(
                                          width: 85.w,
                                          height: 6.5.h,
                                          decoration: BoxDecoration(
                                              color: CustomColor.btnCont,
                                              borderRadius: BorderRadius.circular(8.sp),
                                              border: Border.all(color: CustomColor.btnBorder)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      left: 3.w,
                                                    ),
                                                    height: 3.h,
                                                    width: 5.5.w,
                                                    child: Image.asset(email),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              CustomWidgets.text(LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.email.toString(),
                                                  fontSize: 12.sp),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            GestureDetector(
                              onTap: () async {
                                bool isCheck = getVerifyStatus();

                                if (kDebugMode) {
                                  print('isCheck ::: $isCheck');
                                }

                                //login / signup
                                if (getAuthToken() == "") {
                                  final result = await Get.toNamed(Routes.LOGIN_SCREEN, arguments: 'Pianoteacher');

                                  if (result != null) {
                                    if (kDebugMode) {
                                      print('STUDIO_RENTALS_SCREEN returned: $result');
                                    }
                                    // authController.getUser(
                                    //   isLoaderShow: false,
                                    // );
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
                                } else {
                                  //enquiry now
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
                                    enquireAlert(
                                        context: context,
                                        servicesId: "",
                                        serviceName: "Piano Teacher",
                                        serviceType: "Find Piano Teacher",
                                        userid: LoginSuccessModel.fromJson(
                                          GetStorage().read(
                                            userData,
                                          ),
                                        ).data!.sId.toString(),
                                        isService: false);
                                  }
                                }
                              },
                              child: Container(
                                height: 6.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color: CustomColor.btn,
                                  borderRadius: BorderRadius.circular(
                                    8.sp,
                                  ),
                                  border: Border.all(
                                    color: CustomColor.btnBorder,
                                  ),
                                ),
                                child: Center(
                                  child: Obx(
                                    () {
                                      return (authController.isLogin.value == true)

                                          // enquiry now
                                          ? GestureDetector(
                                              child: CustomWidgets.text(
                                                'Enquire Now',
                                                color: CustomColor.textBtn,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          //login / signup
                                          : CustomWidgets.text(
                                              'Login / Signup',
                                              color: CustomColor.textBtn,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
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
