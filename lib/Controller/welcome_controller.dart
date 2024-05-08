// ignore_for_file: unnecessary_new, unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names, unused_local_variable, unused_import, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Data/Model/cancel_concert_booking_model.dart';
import 'package:piano_project/Data/Model/cancel_studio_booking_model.dart';
import 'package:piano_project/Data/Model/concert_hall_booking_response_model.dart';
import 'package:piano_project/Data/Model/studio_rental_booking_response_model.dart';
import 'package:piano_project/Repository/welcome_repository.dart';
import 'package:piano_project/Routes/routes.dart';
import '../Data/Api/api_manager.dart';
import '../Data/Model/concert_hall_model.dart';
import '../Data/Model/enquire_model.dart';
import '../Data/Model/event_book_user_model.dart';
import '../Data/Model/filter_piano_model.dart';
import '../Data/Model/get_aboutus_model.dart';
import '../Data/Model/get_all_concert_category.dart';
import '../Data/Model/get_all_event_concert_model.dart';
import '../Data/Model/get_banner_model.dart';
import '../Data/Model/get_package_model.dart';
import '../Data/Model/get_pianotype_model.dart';
import '../Data/Model/piano_get_all_catogory.dart';
import '../Data/Model/piano_services_model.dart';
import '../Data/Model/studio_rental_model.dart';
import '../Utils/constant_widgets.dart';
import '../Utils/string_constants.dart';

class WelcomeController extends GetxController {
  var welcomeRepository = WelcomeRepository(APIManager());

//********************** variable declaration **********************

  TabController? tabController;
  RxInt isIndex = 0.obs;

  RxList<StudioData> studioRentalList = <StudioData>[].obs;
  RxList<FilterPiano> filterPianoList = <FilterPiano>[].obs;
  RxList<PianoGetAllCategory> pianoGetAllCategoryList = <PianoGetAllCategory>[].obs;
  RxList<ConcertData> concertHalllList = <ConcertData>[].obs;
  RxList<PianoSerData> pianoServicesList = <PianoSerData>[].obs;
  RxList<GetAllConcertCategory> getAllConcertCategoryList = <GetAllConcertCategory>[].obs;
  RxList<EventData> eventsList = <EventData>[].obs;
  RxList<EventData> upcomingEventList = <EventData>[].obs;
  RxList<EventData> pastEventList = <EventData>[].obs;
  RxList<BannerData> bannerDataList = <BannerData>[].obs;
  RxList<GetPackage> packageDataList = <GetPackage>[].obs;
  RxList<PianoType> pianotypeList = <PianoType>[].obs;
  RxList<BookUserData> bookEventUserList = <BookUserData>[].obs;
  RxList<StudioBookUserData> bookStudioUserList = <StudioBookUserData>[].obs;
  RxList<ConcertBookUserData> bookConcertUserList = <ConcertBookUserData>[].obs;
  Rx<GetAllConcertCategoryModel> getAllConcertCategory1 = GetAllConcertCategoryModel().obs;

  RxBool isEvent = false.obs;
  RxBool showMore = false.obs;
  RxBool showDefaultBanner = false.obs;
  RxBool isCounter = true.obs;
  RxInt gridIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  RxInt ticketCount = 1.obs;
  RxInt selectedWalletIndex = (-1).obs;
  RxInt selectedPackageIndex = (-1).obs;
  RxInt packGroupValue = 0.obs;
  RxInt studioRemaingHours = 0.obs;
  RxString selectService = "".obs;
  RxString studioSelePlan = "".obs;
  RxString concertSelePlan = "".obs;
  RxString studioRentalTerms = "".obs;
  RxString concerthallTerms = "".obs;
  Rx<DateTime> dateTime = DateTime.now().obs;

  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController schoolnameController = TextEditingController();
  TextEditingController teachernameController = TextEditingController();
  TextEditingController performersController = TextEditingController();
  TextEditingController guestsController = TextEditingController();
  TextEditingController pianobrandController = TextEditingController();

//********************** onInit Method **********************//

  @override
  void onInit() {
    super.onInit();
    isIndex.value = 0;
  }
  //********************** calling api in enquire now **********************//

  enquireDataApi(
      {required String location,
      required String date,
      required String note,
      required String serviceType,
      required String serviceName,
      required String UserId,
      required String servicesId,
      required String pianoType,
      required String pianoBrand,
      required BuildContext context}) async {
    //api call
    EnquireModel enquireDetails = await welcomeRepository.enquireDataAPICall(
        serviceType: serviceType,
        serviceName: serviceName,
        location: location,
        note: note,
        date: date,
        userId: UserId,
        servicesId: servicesId,
        pianoType: pianoType,
        pianoBrand: pianoBrand);

    // success message

    if (enquireDetails.status == 1) {
      successSnackBar(duration: Duration(seconds: 20), message: enquireDetails.message);
    } else {
      errorSnackBar(message: enquireDetails.message);
    }
  }

  // get piano type
  getPianoTypeyApi() async {
    pianotypeList.clear();
    GetPianoTypeModel getPianoTypeModel = await welcomeRepository.getpianoTypeAPICall();
    pianotypeList.addAll(getPianoTypeModel.data!);
    log('pianotyprlist :::::::::::::::::${getPianoTypeModel.data!}');
  }
  //********************** calling api in studio rental screen **********************//

  studioRentalDataApi() async {
    //call api
    StudioRentalModel studioRentalDetails = await welcomeRepository.studioRentalDataAPICall();
    studioRentalList.clear();
    //data add in list
    studioRentalList.addAll(studioRentalDetails.data!);
  }

  // studio rental booked
  getStudioBookUserDataApi({required String userId}) async {
    StudioBookUserModel getstudiobookdetail = await welcomeRepository.getStudioBookUserAPICall(userId: userId);
    bookStudioUserList.clear();
    studioRentalTerms.value = getstudiobookdetail.terms!;
    bookStudioUserList.addAll(getstudiobookdetail.data!);
  }

  //studio rental booking are canceling
  BookingCancelDataApi({required String userId, required String bookingId}) async {
    CancelStudioBookModel cancelbooking = await welcomeRepository.bookingCancelApiCall(bookingID: bookingId, userID: userId);

    if (cancelbooking.status == 1) {
      successSnackBar(message: cancelbooking.message, duration: Duration(seconds: 10));
      Get.offAllNamed(Routes.DASHBOARD_SCREEN);
    } else {
      informationSnackBar(message: cancelbooking.message);
    }
  }

  //********************** calling api in piano services screen **********************//

  getAllConcertCategoryApi() async {
    getAllConcertCategory1.value = await welcomeRepository.getAllConcertCategoryAPICall();
    getAllConcertCategoryList.clear();
    getAllConcertCategoryList.addAll(getAllConcertCategory1.value.data!);
  }
//********************** calling api in piano rental screen **********************//

  // piano category
  pianoGetAllCategoryApi() async {
    pianoGetAllCategoryList.clear();
    filterPianoList.clear();
    PianoGetAllCategoryModel pianoGetAllCategoryModel = await welcomeRepository.pianoGetAllCategoryModelAPICall();
    pianoGetAllCategoryList.addAll(pianoGetAllCategoryModel.data!);
    if (pianoGetAllCategoryModel.status == 1) {
      filterPianoApi(id: pianoGetAllCategoryList.first.sId.toString(), isLoaderShow: false);
    }
  }

  // category wise filtering
  filterPianoApi({required String id, required bool isLoaderShow}) async {
    filterPianoList.clear();
    FilterPianoModel filterPianoModel = await welcomeRepository.filterPianoAPICall(id: id, isLoaderShow: isLoaderShow);
    filterPianoList.addAll(filterPianoModel.data!);
  }

//********************** calling api in concerts hall screen **********************//

  concertDataApi() async {
    concertHalllList.clear();
    ConcertHallModel concertsDetails = await welcomeRepository.concertHallDataAPICall();
    concertHalllList.addAll(concertsDetails.data!);
  }

  // oncert hall booked
  getConcertBookUserDataApi({required String userId}) async {
    ConcertBookUserModel getconcertbookdetail = await welcomeRepository.getConcertBookUserAPICall(userId: userId);
    bookConcertUserList.clear();
    concerthallTerms.value = getconcertbookdetail.terms!;
    bookConcertUserList.addAll(getconcertbookdetail.data!);
  }

  //concert hall booking are canceling
  ConcertBookingCancelDataApi({required String userId, required String bookingId}) async {
    CancelConcertBookModel cancelbooking = await welcomeRepository.concertbookingCancelApiCall(bookingID: bookingId, userID: userId);

    if (cancelbooking.status == 1) {
      successSnackBar(message: cancelbooking.message, duration: Duration(seconds: 10));
      Get.offAllNamed(Routes.DASHBOARD_SCREEN);
    } else {
      informationSnackBar(message: cancelbooking.message);
    }
  }

  //********************** calling api in piano services screen **********************//

  pianoServicesDataApi() async {
    pianoServicesList.clear();
    PianoServicesModel pianoSerDetails = await welcomeRepository.pianoServicesDataAPICall();
    pianoServicesList.addAll(pianoSerDetails.data!);
    if (kDebugMode) {
      print(pianoServicesList.toString());
    }
  }

  //********************** calling api in piano services screen **********************//

  eventsDataApi({bool isLoaderShow = true}) async {
    eventsList.clear();
    EventResponseModel eventsDetails = await welcomeRepository.eventsDataAPICall(isLoaderShow: isLoaderShow);
    eventsList.addAll(eventsDetails.data!);
    filterUpcomingEvent();
    filterPastEvent();
  }

  //filter upcoming event
  filterUpcomingEvent() {
    upcomingEventList.clear();
    for (var element in eventsList) {
      DateTime now = DateTime.now();
      DateTime eventDateTime = DateFormat("dd/MM/yyyy HH:mm").parse(element.date.toString() + " " + element.time.toString());

      if (eventDateTime.isAfter(now)) {
        upcomingEventList.add(element);
      }
    }
  }

  //filter past event
  filterPastEvent() {
    pastEventList.clear();
    for (var element in eventsList) {
      DateTime now = DateTime.now();
      DateTime eventDateTime = DateFormat("dd/MM/yyyy HH:mm").parse(element.date.toString() + " " + element.time.toString());

      if (eventDateTime.isBefore(now)) {
        pastEventList.add(element);
      }
    }
  }

  //event and concert booked
  getEventBookUserDataApi({required String userId}) async {
    bookEventUserList.clear();
    EventBookUserModel getPianoTypeModel = await welcomeRepository.getEventBookUserAPICall(userId: userId);

    bookEventUserList.addAll(getPianoTypeModel.data!);
  }

  // ticket increment method
  ticketIncrement() {
    isCounter.value = true;
    if (ticketCount.value < 4) {
      ticketCount.value++;
    }
  }

  // ticket decrement method
  ticketDecrement() {
    isCounter.value = false;
    if (ticketCount.value > 1) {
      ticketCount.value--;
    }
  }

  //********************** calling api of banner **********************//

  getBannerApi({required bool isLoaderShow}) async {
    // bannerDataList.clear();
    GetBannerModel getBannerModel = await welcomeRepository.getBannerAPICall(isLoaderShow: isLoaderShow);
    bannerDataList.addAll(getBannerModel.data!);
    if (getBannerModel.status == 1) {
      showDefaultBanner.value = true;
    }
  }

  //********************** calling api of get package **********************//

  getPackageApi() async {
    packageDataList.clear();

    GetPackageModel getPackageModel = await welcomeRepository.getPackageAPICall(isLoaderShow: true);
    packageDataList.addAll(getPackageModel.data!);
  }
}
