// ignore_for_file: unrelated_type_equality_checks, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piano_project/Controller/welcome_controller.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/welcome_screen.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/network_controller.dart';
import '../../Utils/app_color.dart';
import '../../Utils/string_constants.dart';
import '../../Widget/custom_indicator.dart';
import 'FaqScreen/faq_screen.dart';
import 'MyActivityScreen/my_activity_screen.dart';
import 'ProfileScreen/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  final WelcomeController welcomeScreen = Get.put(
    WelcomeController(),
  );
  NetworkController networkController = Get.put(NetworkController(), permanent: true);

  @override
  void initState() {
    super.initState();
    welcomeScreen.getBannerApi(isLoaderShow: true);
    welcomeScreen.tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    welcomeScreen.isIndex.value = 0;
    welcomeScreen.tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Obx(
        () {
          return Material(
            color: CustomColor.bgBottem,
            child: TabBar(
              indicator: TopIndicator(),
              indicatorPadding: EdgeInsets.only(
                left: 8.5.w,
                right: 8.5.w,
              ),
              controller: welcomeScreen.tabController,
              padding: SizerUtil.deviceType == DeviceType.mobile
                  ? const EdgeInsets.only(bottom: 10)
                  : const EdgeInsets.only(
                      bottom: 40,
                    ),
              onTap: (value) {
                welcomeScreen.isIndex.value = value;
              },
              tabs: [
                CustomWidgets.CustomTab(
                  child: Image.asset(homeIcon,
                      color: (welcomeScreen.isIndex == 0) ? CustomColor.btnSelect : CustomColor.btnUnselect,
                      scale: SizerUtil.deviceType == DeviceType.mobile ? 1 : 0.1),
                ),
                CustomWidgets.CustomTab(
                  child: Image.asset(faqIcon,
                      color: (welcomeScreen.isIndex == 1) ? CustomColor.btnSelect : CustomColor.btnUnselect,
                      scale: SizerUtil.deviceType == DeviceType.mobile ? 1 : 0.1),
                ),
                CustomWidgets.CustomTab(
                  child: Image.asset(myActivityIcon,
                      color: (welcomeScreen.isIndex == 2) ? CustomColor.btnSelect : CustomColor.btnUnselect,
                      scale: SizerUtil.deviceType == DeviceType.mobile ? 1 : 0.1),
                ),
                CustomWidgets.CustomTab(
                  child: Image.asset(profileIcon,
                      color: (welcomeScreen.isIndex == 3) ? CustomColor.btnSelect : CustomColor.btnUnselect,
                      scale: SizerUtil.deviceType == DeviceType.mobile ? 1 : 0.1),
                ),
              ],
            ),
          );
        },
      ),
      body: TabBarView(
        controller: welcomeScreen.tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const WelcomeScreen(),
          const MyActivityScreen(),
          FaqScreen(
            isSelected: false,
          ),
          const ProfileScreen()
        ],
      ),
    );
  }
}
