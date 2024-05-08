// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Controller/welcome_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class PianoServicesScreen extends StatefulWidget {
  const PianoServicesScreen({Key? key}) : super(key: key);

  @override
  State<PianoServicesScreen> createState() => _PianoServicesScreenState();
}

class _PianoServicesScreenState extends State<PianoServicesScreen> {
  final WelcomeController welcomeController = Get.put(WelcomeController());

  @override
  void initState() {
    welcomeController.pianoServicesDataApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: CustomColor.btnAbout,
          body: Stack(
            children: [
              Image.asset(backgroundImage),
              Column(
                children: [
                  CustomWidgets.CustAppbar(title: "Piano Services"),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                      ),
                      child: RefreshIndicator(
                        color: CustomColor.btn,
                        onRefresh: () async {
                          welcomeController.pianoServicesDataApi();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Obx(
                            () {
                              return isInternetAvailable.value == true
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        CustomWidgets.text(
                                          "Whether you need to Tune, Rent, Move, Repaint, Repair or Assess\n your piano, our expert & dedicated team of professionals will\n gladly help you.",
                                          softWrap: true,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.2.sp : 8.sp,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        //First piano services
                                        welcomeController.pianoServicesList.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                    Routes.PIANO_SERVICES_DETAIL_SCREEN,
                                                    arguments: welcomeController.pianoServicesList.first,
                                                  );
                                                },
                                                child: Container(
                                                  height: SizerUtil.deviceType == DeviceType.mobile ? 22.h : 28.h,
                                                  decoration: BoxDecoration(
                                                    color: CustomColor.btnAbout,
                                                    border: Border.all(
                                                      color: CustomColor.btnGridConBorder,
                                                    ),
                                                    borderRadius: BorderRadius.circular(
                                                      10.sp,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: SizerUtil.deviceType == DeviceType.mobile
                                                        ? EdgeInsets.only(
                                                            right: 0.7.h,
                                                            left: 0.7.h,
                                                          )
                                                        : const EdgeInsets.only(right: 15, left: 15, top: 5),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 0.7.h),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: SizedBox(
                                                              height: SizerUtil.deviceType == DeviceType.mobile ? 14.h : 20.h,
                                                              width: 80.h,
                                                              child: (welcomeController.pianoServicesList.first.file != null)
                                                                  ? CustomWidgets.customImage(image: welcomeController.pianoServicesList.first.file!)
                                                                  : CustomWidgets.NoImage(),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        CustomWidgets.text(
                                                          welcomeController.pianoServicesList.first.name.toString(),
                                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 10.sp,
                                                          fontWeight: FontWeight.w800,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        //piano services

                                        (welcomeController.pianoServicesList.isNotEmpty)
                                            ? GridView.builder(
                                                physics: const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: welcomeController.pianoServicesList.length - 1,
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisExtent: 19.h,
                                                  mainAxisSpacing: 10,
                                                  crossAxisSpacing: 10,
                                                ),
                                                itemBuilder: (context, index) {
                                                  if (kDebugMode) {
                                                    print(
                                                        "welcomeController.studioRentalList.length ::::: ${welcomeController.pianoServicesList.length}");
                                                  }
                                                  int newIndex = index + 1;
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        Routes.PIANO_SERVICES_DETAIL_SCREEN,
                                                        arguments: welcomeController.pianoServicesList[newIndex],
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: CustomColor.btnAbout,
                                                        border: Border.all(
                                                          color: CustomColor.btnGridConBorder,
                                                        ),
                                                        borderRadius: BorderRadius.circular(
                                                          8.sp,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: 1.h,
                                                                  right: 1.h,
                                                                  top: SizerUtil.deviceType == DeviceType.mobile ? 0 : 15,
                                                                  bottom: SizerUtil.deviceType == DeviceType.mobile ? 0 : 5),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(5),
                                                                child: SizedBox(
                                                                  height: SizerUtil.deviceType == DeviceType.mobile ? 13.h : 14.h,
                                                                  width: SizerUtil.deviceType == DeviceType.mobile ? 13.h : 20.h,
                                                                  child: (welcomeController.pianoServicesList[newIndex].file != null)
                                                                      ? CustomWidgets.customImage(
                                                                          image: welcomeController.pianoServicesList[newIndex].file!)
                                                                      : CustomWidgets.NoImage(),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 2.5.h,
                                                              width: 25.w,
                                                              child: Center(
                                                                child: CustomWidgets.text(
                                                                  welcomeController.pianoServicesList[newIndex].name!,
                                                                  softWrap: true,
                                                                  textAlign: TextAlign.center,
                                                                  fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 8.sp,
                                                                  fontWeight: FontWeight.w800,
                                                                  maxLine: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : Container(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : CustomWidgets.NoInertnet(top: 200);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
