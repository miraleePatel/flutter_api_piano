// ignore_for_file: non_constant_identifier_names, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Controller/faq_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/string_constants.dart';
import '../../../Widget/custom_widget.dart';

class FaqScreen extends StatefulWidget {
  bool isSelected = false;

  FaqScreen({Key? key, required this.isSelected}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  FaqController faqController = Get.put(FaqController());

  @override
  void initState() {
    faqController.faqDataApi();
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(
              () {
                return Stack(
                  children: [
                    Image.asset(backgroundImage),
                    widget.isSelected ? CustomWidgets.CustAppbar(title: "") : Container(),
                    isInternetAvailable.value == true
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.isSelected
                                    ? SizedBox(
                                        height: 6.h,
                                      )
                                    : SizedBox(
                                        height: 3.h,
                                      ),
                                Image.asset(
                                  houseFaq,
                                  scale: SizerUtil.deviceType == DeviceType.mobile ? 2.8 : 1.3,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  height: SizerUtil.deviceType == DeviceType.mobile ? 7.h : 10.h,
                                  width: 58.w,
                                  child: CustomWidgets.text(
                                    'Your Piano Investment &\n Care Guide',
                                    fontSize: SizerUtil.deviceType == DeviceType.mobile ? 16.5.sp : 12.5.sp,
                                    fontWeight: FontWeight.w800,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Obx(
                                  () => ListView.separated(
                                    itemCount: faqController.faqList.length,
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                      right: 5.w,
                                      top: 2.h,
                                      bottom: 3.h,
                                    ),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Obx(() => CustomWidgets.customFaq(
                                          isSelected: faqController.selected[index],
                                          onTap: () {
                                            faqController.selected[index] = !faqController.selected[index];
                                          },
                                          image: faqController.faqList[index].file!,
                                          Text: faqController.faqList[index].title!.toUpperCase(),
                                          des: faqController.faqList[index].desc!));
                                    },
                                    separatorBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return SizedBox(
                                        height: 1.8.h,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                )
                              ],
                            ),
                          )
                        : CustomWidgets.NoInertnet(top: 250)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
