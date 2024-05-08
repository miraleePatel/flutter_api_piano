// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Controller/welcome_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../../Data/Model/filter_piano_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/string_constants.dart';
import '../../../../Widget/custom_widget.dart';

class PianoRentalScreen extends StatefulWidget {
  const PianoRentalScreen({Key? key}) : super(key: key);

  @override
  State<PianoRentalScreen> createState() => _PianoRentalScreenState();
}

class _PianoRentalScreenState extends State<PianoRentalScreen> {
  WelcomeController welcomeController = Get.put(WelcomeController());

  @override
  void initState() {
    welcomeController.pianoGetAllCategoryApi();
    print(isInternetAvailable.value);
    super.initState();
  }

  @override
  void dispose() {
    welcomeController.currentIndex.value = 0;
    super.dispose();
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
              Image.asset(
                backgroundImage,
              ),
              Column(
                children: [
                  CustomWidgets.CustAppbar(title: "Piano Rentals"),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                        top: 1.h,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Obx(
                          () {
                            return isInternetAvailable.value == true
                                ? Column(
                                    children: [
                                      Container(
                                        height: SizerUtil.deviceType == DeviceType.mobile ? 14.h : 24.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              piano,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: CustomWidgets.text(
                                          "DESTINATION TO THE BIGGEST SELECTION \n OF PIANO RENTALS IN UAE!",
                                          softWrap: true,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 13.5.sp : 10.sp,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Divider(
                                        height: 5.h,
                                        endIndent: 40.w,
                                        indent: 40.w,
                                        thickness: 1,
                                      ),
                                      Center(
                                        child: CustomWidgets.text(
                                          "PIANO EVENT HIRE YOU MIGHT BE \n CONSIDERING INCLUDING:",
                                          softWrap: true,
                                          fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.5.sp : 10.sp,
                                          textAlign: TextAlign.center,
                                          color: CustomColor.textStudioRentals,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Center(
                                          child: CustomWidgets.text(
                                        "CONCERT  |  RECITAL THEATER  |  PLAY  |  PARTIES  |  WEDDING \n MUSIC VIDEO  |  PHOTO SHOOT  |  MEMORIAL SERVICE",
                                        softWrap: true,
                                        fontSize: SizerUtil.deviceType == DeviceType.mobile ? 8.5.sp : 7.sp,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w800,
                                      )),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Center(
                                        child: Column(
                                          children: [
                                            // piano category
                                            GridView.builder(
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4, childAspectRatio: 2.3, mainAxisSpacing: 15),
                                                shrinkWrap: true,
                                                // itemCount: welcomeController
                                                //         .showMore.value
                                                //     ? welcomeController
                                                //         .pianoGetAllCategoryList
                                                //         .length
                                                //     : welcomeController
                                                //                 .pianoGetAllCategoryList
                                                //                 .length <
                                                //             4
                                                //         ? welcomeController
                                                //             .pianoGetAllCategoryList
                                                //             .length
                                                //         : 4,
                                                itemCount: welcomeController.pianoGetAllCategoryList.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        welcomeController.currentIndex.value = index;
                                                        welcomeController.filterPianoApi(
                                                            id: welcomeController
                                                                .pianoGetAllCategoryList
                                                                // ignore: invalid_use_of_protected_member
                                                                .value[index]
                                                                .sId
                                                                .toString(),
                                                            isLoaderShow: true);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: 1.5.w,
                                                          right: 1.5.w,
                                                        ),
                                                        height: SizerUtil.deviceType == DeviceType.mobile ? 3.5.h : 3.h,
                                                        width: SizerUtil.deviceType == DeviceType.mobile ? 20.w : 18.w,
                                                        decoration: BoxDecoration(
                                                            color: welcomeController.currentIndex.value == index
                                                                ? CustomColor.btnSelect
                                                                : CustomColor.black,
                                                            borderRadius: BorderRadius.circular(5.sp)),
                                                        child: Center(
                                                          child: SizedBox(
                                                            width: 18.w,
                                                            child: CustomWidgets.text(
                                                              welcomeController.pianoGetAllCategoryList[index].name.toString(),
                                                              color: CustomColor.white,
                                                              softWrap: true,
                                                              fontSize: SizerUtil.deviceType == DeviceType.mobile ? 7.5.sp : 6.5.sp,
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                }),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            // Visibility(
                                            //   visible: !welcomeController
                                            //           .showMore.value &&
                                            //       welcomeController
                                            //               .pianoGetAllCategoryList
                                            //               .length >
                                            //           4,
                                            //   child: SizedBox(
                                            //     width: 30.w,
                                            //     height: 4.h,
                                            //     child: GestureDetector(
                                            //       onTap: () {
                                            //         welcomeController
                                            //             .showMore.value = true;
                                            //       },
                                            //       child: Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment
                                            //                 .center,
                                            //         children: [
                                            //           CustomWidgets.text(
                                            //               'Show more',
                                            //               color: CustomColor
                                            //                   .textDate),
                                            //           SizedBox(
                                            //             width: 2.w,
                                            //           ),
                                            //           Icon(
                                            //               Icons
                                            //                   .keyboard_arrow_down_sharp,
                                            //               size: 15.sp,
                                            //               color: CustomColor
                                            //                   .textDate)
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      // category wise piano
                                      Center(
                                        child: welcomeController.filterPianoList.isNotEmpty
                                            ? RefreshIndicator(
                                                onRefresh: () async {
                                                  await welcomeController.pianoGetAllCategoryApi();
                                                },
                                                child: GridView.builder(
                                                  physics: const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: welcomeController.filterPianoList.length,
                                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 16.h,
                                                    mainAxisExtent: 19.5.h,
                                                    mainAxisSpacing: 2.h,
                                                    crossAxisSpacing: 2.h,
                                                  ),
                                                  itemBuilder: (context, index) {
                                                    FilterPiano filterList = welcomeController.filterPianoList[index];
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          Routes.PIANO_RENTALS_DETAIL_SCREEN,
                                                          arguments: welcomeController.filterPianoList[index],
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
                                                              filterList.file != ""
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(left: 1.h, right: 1.h),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        child: SizedBox(
                                                                          height: 13.h,
                                                                          child: CustomWidgets.customImage(image: filterList.file.toString()),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : CustomWidgets.NoImage(),
                                                              SizedBox(
                                                                width: 25.w,
                                                                child: CustomWidgets.text(
                                                                  filterList.brand!,
                                                                  softWrap: true,
                                                                  fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 7.sp,
                                                                  textAlign: TextAlign.center,
                                                                  fontWeight: FontWeight.w800,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                  top: 15.h,
                                                ),
                                                child: Center(
                                                  child: CustomWidgets.text(
                                                    "Not Found",
                                                    softWrap: true,
                                                    textAlign: TextAlign.center,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                    ],
                                  )
                                : CustomWidgets.NoInertnet(top: 200);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
