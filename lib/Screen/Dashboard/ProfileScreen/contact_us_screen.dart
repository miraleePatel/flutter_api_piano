import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Controller/profile_controller.dart';
import 'package:piano_project/Utils/app_color.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/constant_widgets.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.contactUsDataApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                backgroundImage,
              ),
              CustomWidgets.CustAppbar(
                title: "Contact Us",
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 7.5.h,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Obx(
                    () {
                      // No internet connection
                      return isInternetAvailable.value == true
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomWidgets.text(
                                  'For your comfort and ease to reach us, We are open 7 days a week,\n We are looking forward to welcoming you.',
                                  textAlign: TextAlign.center,
                                  fontSize: 9.5.sp,
                                ),
                                Obx(
                                  () {
                                    return (profileController.contactUsDetails.value.status == 1)
                                        ? Column(
                                            children: [
                                              // Our Address
                                              CustomWidgets.customContainer(
                                                margintop: 2.h,
                                                top: 4.h,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        "Our Address:",
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        "Main Showroom:",
                                                        fontSize: 12.sp,
                                                        color: CustomColor.btn,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        '${profileController.contactUsDetails.value.data![0].mainShowroom!.address}: ${profileController.contactUsDetails.value.data![0].mainShowroom!.phoneNo}',
                                                        fontSize: 9.sp,
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        "Steinway Gallery Dubai:",
                                                        fontSize: 12.sp,
                                                        color: CustomColor.btn,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        '${profileController.contactUsDetails.value.data![0].steinwayLounge!.address}: ${profileController.contactUsDetails.value.data![0].steinwayLounge!.phoneNo}',
                                                        fontSize: 9.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              //Contact Us
                                              CustomWidgets.customContainer(
                                                margintop: 2.h,
                                                top: 4.h,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        "Contact Us",
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        "Sales Enquiry:",
                                                        fontSize: 12.sp,
                                                        color: CustomColor.btn,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        '${profileController.contactUsDetails.value.data![0].salesEnquiry!.phoneNo} ',
                                                        fontSize: 10.sp,
                                                      ),
                                                      CustomWidgets.text(
                                                        '${profileController.contactUsDetails.value.data![0].salesEnquiry!.email}',
                                                        fontSize: 10.sp,
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        "Rental Enquiry:",
                                                        fontSize: 12.sp,
                                                        color: CustomColor.btn,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        '${profileController.contactUsDetails.value.data![0].rentalEnquiry!.phoneNo}',
                                                        fontSize: 9.5.sp,
                                                      ),
                                                      CustomWidgets.text(
                                                        '${profileController.contactUsDetails.value.data![0].rentalEnquiry!.email}',
                                                        fontSize: 9.5.sp,
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        "Service Enquiry:",
                                                        fontSize: 12.sp,
                                                        color: CustomColor.btn,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        '${profileController.contactUsDetails.value.data![0].serviceEnquiry!.phoneNo}',
                                                        fontSize: 9.5.sp,
                                                      ),
                                                      CustomWidgets.text(
                                                        '${profileController.contactUsDetails.value.data![0].serviceEnquiry!.email}',
                                                        fontSize: 9.5.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // whatsapp & telegram
                                              CustomWidgets.customContainer(
                                                margintop: 2.h,
                                                top: 4.h,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      CustomWidgets.text(
                                                        "Live Chat",
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          // whatsapp

                                                          GestureDetector(
                                                            onTap: () {
                                                              print("whatsapp....${profileController.contactUsDetails.value.data![0].whatsAppNo}");
                                                              var whatsappno = profileController.contactUsDetails.value.data![0].whatsAppNo;
                                                              // To remove the keyboard when button is pressed
                                                              FocusManager.instance.primaryFocus?.unfocus();

                                                              var whatsappUrl = "whatsapp://send?phone=${whatsappno}";

                                                              try {
                                                                launch(whatsappUrl);
                                                              } catch (e) {
                                                                //To handle error and display error message
                                                                errorSnackBar(message: "Unable to open whatsapp");
                                                              }
                                                            },
                                                            child: Image.asset(whatsapp, scale: 12),
                                                          ),
                                                          SizedBox(
                                                            width: 3.w,
                                                          ),

                                                          // telegram
                                                          GestureDetector(
                                                            onTap: () {
                                                              print("telegram....${profileController.contactUsDetails.value.data![0].telegramNo}");
                                                              var telegramNO = profileController.contactUsDetails.value.data![0].telegramNo;
                                                              FocusManager.instance.primaryFocus?.unfocus();

                                                              // var telegramUrl = "https://t.me/gulfiza_hop";
                                                              // var telegramUrl = "https://telegram.me/+971524434135";
                                                              var telegramUrl = "https://t.me/${telegramNO}";
                                                              try {
                                                                print("${telegramUrl}");
                                                                launch(telegramUrl);
                                                              } catch (e) {
                                                                //To handle error and display error message
                                                                errorSnackBar(message: "Unable to open Telegram");
                                                              }
                                                            },
                                                            child: Image.asset(
                                                              telegram,
                                                              scale: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      /*      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            try {
                                                              launch(
                                                                  "https://secure.paytabs.com/payment/page/5FF925EA82E40570079281717AB44D1719356844C8423F598BA6E8C3/start");
                                                            } catch (e) {
                                                              //To handle error and display error message
                                                              errorSnackBar(message: "Unable to open Telegram");
                                                            }
                                                          },
                                                          child: Text("Url")) */
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container();
                                  },
                                )
                              ],
                            )
                          : CustomWidgets.NoInertnet(top: 200);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
