// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Data/Model/piano_services_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../Data/Model/login_response_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_button.dart';
import '../../../../Widget/custom_widget.dart';

class PianoServicesDetailesScreen extends StatefulWidget {
  const PianoServicesDetailesScreen({Key? key}) : super(key: key);

  @override
  State<PianoServicesDetailesScreen> createState() => _PianoServicesDetailesScreenState();
}

class _PianoServicesDetailesScreenState extends State<PianoServicesDetailesScreen> {
  PianoSerData pianoServicesModel = Get.arguments;

  @override
  void initState() {
    welcomeController.getPianoTypeyApi();
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
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomColor.btnAbout,
          body: Stack(
            children: [
              Image.asset(backgroundImage),
              Obx(
                () {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomWidgets.CustAppbar(
                        title: pianoServicesModel.name!,
                      ),
                      isInternetAvailable.value == true
                          ? Expanded(
                              child: CustomWidgets.customContainer(
                                margintop: 0.h,
                                top: 15.h,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 1.h,
                                    left: 1.h,
                                    right: 1.h,
                                    bottom: 2.h,
                                  ),
                                  child: Column(
                                    children: [
                                      // piano services image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: SizedBox(
                                          height: 20.h,
                                          width: 85.w,
                                          child: (pianoServicesModel.file != null)
                                              ? CustomWidgets.customImage(
                                                  image: '${pianoServicesModel.file}',
                                                )
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
                                              // piano services description
                                              CustomWidgets.text(fontSize: 10.sp, pianoServicesModel.desc!),
                                              SizedBox(height: 2.h),

                                              //table
                                              (pianoServicesModel.priceDetail!.isNotEmpty &&
                                                      pianoServicesModel.priceDetail![0].detail.toString() != '-' &&
                                                      pianoServicesModel.priceDetail![0].detail.toString() != '')
                                                  ? Container(
                                                      padding: const EdgeInsets.all(15),
                                                      child: Table(
                                                          border: TableBorder.all(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.grey.shade300,
                                                          ),
                                                          children: pianoServicesModel.priceDetail!.map((priceDetail) {
                                                            return TableRow(children: [
                                                              // charges
                                                              TableCell(
                                                                  child: Padding(
                                                                padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                                                                child: CustomWidgets.text(
                                                                  priceDetail.detail.toString(),
                                                                  textAlign: TextAlign.start,
                                                                  fontSize: 11.sp,
                                                                ),
                                                              )),
                                                              //price
                                                              TableCell(
                                                                  child: Padding(
                                                                      padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 4.w, bottom: 1.h),
                                                                      child: CustomWidgets.text(
                                                                        priceDetail.price.toString(),
                                                                        textAlign: TextAlign.start,
                                                                        fontSize: 11.sp,
                                                                        fontWeight: FontWeight.w900,
                                                                      ))),
                                                            ]);
                                                          }).toList()))
                                                  : Container(),
                                              SizedBox(height: 2.h),
                                              //notes
                                              pianoServicesModel.note != null && pianoServicesModel.note != ""
                                                  ? CustomWidgets.text(
                                                      fontSize: 10.sp,
                                                      color: CustomColor.btn,
                                                      '*${pianoServicesModel.note}',
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : CustomWidgets.NoInertnet(top: 120),
                      SizedBox(
                        height: 3.h,
                      ),
                      isInternetAvailable.value == true
                          ? CustomButton(
                              width: 90.w,
                              onPressed: () {
                                bool isCheck = getVerifyStatus();

                                print('isCheck ::: $isCheck');
                                if (getAuthToken() == "") {
                                  Get.toNamed(Routes.LOGIN_SCREEN);
                                } else {
                                  // enqury alert
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
                                        serviceName: "Piano Service",
                                        serviceType: pianoServicesModel.name!,
                                        userid: LoginSuccessModel.fromJson(
                                          GetStorage().read(
                                            userData,
                                          ),
                                        ).data!.sId.toString(),
                                        isService: true);
                                  }
                                }
                              },
                              text: 'Enquire Now',
                            )
                          : Container(),
                      SizedBox(
                        height: 3.h,
                      ),
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
