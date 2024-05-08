// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../Data/Api/api_manager.dart';
import '../Data/Model/get_activity_model.dart';
import '../Data/Model/login_response_model.dart';
import '../Repository/activity_repository.dart';
import '../Utils/constant_widgets.dart';
import '../Utils/string_constants.dart';

class ActivityController extends GetxController {
  final activityRepository = ActivityRepository(APIManager());

//********************** variable declaration **********************//

  RxList<Activity> activityList = <Activity>[].obs;
  RxList<Activity> todayActivityList = <Activity>[].obs;
  RxList<Activity> weekActivityList = <Activity>[].obs;
  RxList<Activity> otherActivityList = <Activity>[].obs;
  RxList<Notification> notificationList = <Notification>[].obs;
  RxList<Notification> filterNotificationList = <Notification>[].obs;

  Rx<GetActivityModel> getActivityModel = GetActivityModel().obs;
  Rx<ListData> listData = ListData().obs;
  RxString timeAgoString = "".obs;

//********************** get activity method **********************//

  getActivity() {
    bool isCheck = getVerifyStatus();
    if (getAuthToken() == "") {
      activityDataApi(
          userId: LoginSuccessModel.fromJson(
        GetStorage().read(
          userData,
        ),
      ).data!.sId.toString());
    }
  }

//********************** call api of activity **********************//

  activityDataApi({required String userId}) async {
    activityList.clear();
    notificationList.clear();
    getActivityModel.value = await activityRepository.activityAPICall(id: userId);
    listData.value = getActivityModel.value.data!;
    activityList.addAll(listData.value.activity as Iterable<Activity>);
    notificationList.addAll(listData.value.notification as Iterable<Notification>);
    if (kDebugMode) {
      print("List leangh ....... ${activityList.length}");
    }
    filterTodayActivity();
    filterWeekActivity();
    otherActivity();
    filterNotification();
  }

//********************** filter today activity **********************//

  filterTodayActivity() {
    todayActivityList.clear();
    for (var element in activityList) {
      DateTime now = DateTime.now();
      DateTime utcDateTime = DateTime.parse(element.dateTime.toString());
      DateTime localDateTime = utcDateTime.toLocal();
      String formattedDateTime = DateFormat('dd MMM, yyyy').format(localDateTime);
      DateTime eventDate = DateFormat("dd MMM, yyyy").parse(formattedDateTime);

      if (eventDate.year == now.year && eventDate.month == now.month && eventDate.day == now.day) {
        todayActivityList.add(element);
      }
    }
  }

//********************** filter weekly activity **********************//

  filterWeekActivity() {
    weekActivityList.clear();
    DateTime now = DateTime.now();
    DateTime nextWeek = now.add(const Duration(days: 7));

    for (var element in activityList) {
      DateTime utcDateTime = DateTime.parse(element.dateTime.toString());
      DateTime localDateTime = utcDateTime.toLocal();
      String formattedDateTime = DateFormat('d MMM, yyyy').format(localDateTime);
      DateTime eventDate = DateFormat("d MMM, yyyy").parse(formattedDateTime);

      if (eventDate.year == now.year && eventDate.month == now.month && eventDate.day == now.day) {
        continue;
      }
      if (eventDate.isBefore(nextWeek) && eventDate.year == nextWeek.year && eventDate.month == nextWeek.month && eventDate.day <= nextWeek.day) {
        weekActivityList.add(element);
      }
    }
  }

//********************** filter other activity **********************//

  otherActivity() {
    otherActivityList.clear();
    DateTime now = DateTime.now();
    DateTime nextWeek = now.add(const Duration(days: 7));

    for (var element in activityList) {
      DateTime utcDateTime = DateTime.parse(element.dateTime.toString());
      DateTime localDateTime = utcDateTime.toLocal();
      String formattedDateTime = DateFormat('d MMM, yyyy').format(localDateTime);
      DateTime eventDate = DateFormat("d MMM, yyyy").parse(formattedDateTime);

      if (eventDate.year == now.year && eventDate.month == now.month && eventDate.day == now.day) {
        continue; // Exclude current day's activity
      }
      if (eventDate.isBefore(nextWeek) && eventDate.year == nextWeek.year && eventDate.month == nextWeek.month && eventDate.day <= nextWeek.day) {
        continue; // Exclude activities for the upcoming week
      }
      if (!todayActivityList.contains(element) && !weekActivityList.contains(element)) {
        otherActivityList.add(element); // Add remaining activities to otherActivityList
      }
    }
  }

//********************** filter notification activity **********************//

  filterNotification() {
    filterNotificationList.clear();
    for (var element in notificationList) {
      DateTime now = DateTime.now();
      DateTime utcDateTime = DateTime.parse(element.dateTime.toString());
      DateTime localDateTime = utcDateTime.toLocal();
      String formattedDateTime = DateFormat('dd MMM, yyyy').format(localDateTime);
      DateTime eventDate = DateFormat("dd MMM, yyyy").parse(formattedDateTime);

      filterNotificationList.add(element);
    }
  }
}
