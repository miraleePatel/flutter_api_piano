// ignore_for_file: unused_import, prefer_is_empty, non_constant_identifier_names, avoid_print, unused_element, unrelated_type_equality_checks, unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Controller/authetication_controller.dart';
import 'package:piano_project/Utils/constant_widgets.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../Controller/profile_controller.dart';
import '../../../Controller/welcome_controller.dart';
import '../../../Data/Model/login_response_model.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/country_list.dart';
import '../../../Widget/custom_button.dart';
import '../../../Widget/custom_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController editProfileController = Get.put(ProfileController());
  AuthController authController = Get.put(AuthController());
  String? url;

  @override
  void initState() {
    super.initState();
    LoginData();
    // authController.getUser(isLoaderShow: false);
    bool isEmpty = GetStorage().read(userData) != null;

    if (isEmpty) {
      print("if.........$isEmpty");
      authController.checkLoginUser(
          email: LoginSuccessModel.fromJson(
        GetStorage().read(
          userData,
        ),
      ).data!.email.toString());
    }
    if (int.parse(editProfileController.phController.text.split(" ").last.length.toString()) == 0) {
      print('len :::::  ${editProfileController.numberLenght.value}');
    } else {
      editProfileController.numberLenght.value = editProfileController.phController.text.split(" ").last.length.toString();
    }
  }

  LoginData() {
    var data = authController.loginDetails.value.data!;

    if (data.fullName != " " && data.fullName != null) {
      editProfileController.nameController.text = authController.loginDetails.value.data!.fullName.toString();
    }

    if (data.email != " " && data.email != null) {
      editProfileController.emailController.text = authController.loginDetails.value.data!.email.toString();
    }

    if (data.countryCode != " " && data.countryCode != null) {
      editProfileController.contryCode.value = authController.loginDetails.value.data!.countryCode.toString();
    }

    if (data.phoneNo != " " && data.phoneNo != null && data.phoneNo != "null") {
      editProfileController.phController.text = authController.loginDetails.value.data!.phoneNo.toString();
    }
    if (data.socialMedia != "google" && data.socialMedia != "apple") {
      data.phoneNo == null
          ? editProfileController.phController.text.split(" ").last = " "
          : editProfileController.phController.text = authController.loginDetails.value.data!.phoneNo.toString();
    }

    if (data.file != "" && data.file != null) {
      editProfileController.flag.value = authController.loginDetails.value.data!.file.toString().split(".").first;
    } else {
      editProfileController.flag.value = "ae";
    }

    if (data.address != " " && data.address != null && data.address != "null") {
      editProfileController.addController.text = authController.loginDetails.value.data!.address.toString();
    } else {
      editProfileController.addController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: CustomColor.btnAbout,
            body: Form(
              key: editProfileController.editKey,
              child: Stack(
                children: [
                  Image.asset(
                    backgroundImage,
                  ),
                  Column(
                    children: [
                      CustomWidgets.CustAppbar(
                        title: "Profile",
                      ),
                      // No internet connection
                      Obx(
                        () {
                          return isInternetAvailable.value == true
                              ? Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 5.h,
                                    ),
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomWidgets.text(
                                              "User Details",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w800,
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            SizedBox(
                                              width: 80.w,
                                              child: CustomTextFiled(
                                                controller: editProfileController.nameController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please Enter Name';
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
                                                controller: editProfileController.emailController,
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
                                                readOnly: true,
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
                                                controller: editProfileController.phController,
                                                validator: (value) {
                                                  if (editProfileController.numberLenght !=
                                                      editProfileController.phController.text.split(" ").last.length.toString()) {
                                                    return 'Phone Number length Must be ${editProfileController.numberLenght.value}';
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
                                                      CustomWidgets.text(
                                                        "${editProfileController.contryCode.value} ",
                                                        fontSize: 13.sp,
                                                      ),
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
                                                        width: 12.w,
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
                                                                            image: AssetImage('assets/flags/${editProfileController.flag.value}.png'),
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
                                                controller: editProfileController.addController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please Enter Your Address';
                                                  }
                                                  return null;
                                                },
                                                hintText: 'Enter Address',
                                                image: Image.asset(
                                                  address,
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                            ),

                                            // update profile
                                            CustomButton(
                                              width: 80.w,
                                              onPressed: () {
                                                if (editProfileController.editKey.currentState!.validate() &&
                                                    editProfileController.nameController.text.trim() != '' &&
                                                    editProfileController.addController.text.trim() != '') {
                                                  editProfileController.editUserDetails(
                                                      LoginSuccessModel.fromJson(
                                                        GetStorage().read(
                                                          userData,
                                                        ),
                                                      ).data!.sId.toString(),
                                                      file: '${editProfileController.flag.value}.png',
                                                      fullName: editProfileController.nameController.text.trim(),
                                                      countryCode: editProfileController.contryCode.value,
                                                      phoneNo: editProfileController.phController.text.trim(),
                                                      address: editProfileController.addController.text.trim(),
                                                      screenName: "editprofile");
                                                }
                                              },
                                              text: 'SAVE',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : CustomWidgets.NoInertnet(top: 200);
                        },
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
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      editProfileController.contryCode.value = countries[index].dialCode;
                    });
                    editProfileController.phController.text = editProfileController.phController.text.split(" ").last;
                    editProfileController.numberLenght.value = countries[index].maxLength.toString();
                    editProfileController.flag.value = countries[index].code.toLowerCase();
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
