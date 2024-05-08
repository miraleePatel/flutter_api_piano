// ignore_for_file: unused_import

import 'package:piano_project/Data/Model/cancel_concert_booking_model.dart';
import 'package:piano_project/Data/Model/cancel_studio_booking_model.dart';
import 'package:piano_project/Data/Model/studio_rental_booking_response_model.dart';
import 'package:piano_project/Data/Model/studio_rental_model.dart';
import '../Data/Api/api_manager.dart';
import '../Data/Model/concert_hall_booking_response_model.dart';
import '../Data/Model/concert_hall_model.dart';
import '../Data/Model/enquire_model.dart';
import '../Data/Model/event_book_user_model.dart';
import '../Data/Model/event_booking_response_model.dart';
import '../Data/Model/filter_piano_model.dart';
import '../Data/Model/get_all_concert_category.dart';
import '../Data/Model/get_all_event_concert_model.dart';
import '../Data/Model/get_banner_model.dart';
import '../Data/Model/get_package_model.dart';
import '../Data/Model/get_pianotype_model.dart';
import '../Data/Model/piano_get_all_catogory.dart';
import '../Data/Model/piano_services_model.dart';
import '../Utils/string_constants.dart';

class WelcomeRepository {
  final APIManager apiManager;

  WelcomeRepository(this.apiManager);

//********************** enquire now api call **********************//

  Future<EnquireModel> enquireDataAPICall({
    required String userId,
    required String serviceType,
    required String serviceName,
    required String location,
    required String note,
    required String date,
    required String pianoType,
    required String pianoBrand,
    String? servicesId,
  }) async {
    var jsonData = await apiManager.postAPICall(
      url: '${adminUrl}enquire-now',
      params: {
        "user_detail": userId,
        "service_type": serviceType,
        "service_id": servicesId,
        "service_name": serviceName,
        "location": location,
        "date": date,
        "note": note,
        "piano_service": {"piano_type": pianoType, "piano_brand": pianoBrand}
      },
    );
    var response = EnquireModel.fromJson(jsonData);

    return response;
  }
  
  //********************** studio rental data api call **********************//

  Future<StudioRentalModel> studioRentalDataAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-all-studio-rentals',
    );
    var response = StudioRentalModel.fromJson(jsonData);
    return response;
  }

  //studio rental booked
  Future<StudioBookUserModel> getStudioBookUserAPICall(
      {bool isLoaderShow = true, required String userId}) async {
    var jsonData = await apiManager.getAPICall(
        isToken: true,
        url: '${adminUrl}studio-book-user/$userId',
        isLoaderShow: isLoaderShow);
    var response = StudioBookUserModel.fromJson(jsonData);
    return response;
  }

  //studio rental are canceling
  Future<CancelStudioBookModel> bookingCancelApiCall({
    required String userID,
    required String bookingID,
  }) async {
    var jsonData = await apiManager.postAPICall(
      url: '${adminUrl}cancel-studio-book',
      params: {
        "booking_id": bookingID,
        "user_id": userID,
      },
    );

    var response = CancelStudioBookModel.fromJson(jsonData);
    return response;
  }
  
  //********************** Piano Rental data api call **********************//

  Future<PianoGetAllCategoryModel> pianoGetAllCategoryModelAPICall() async {
    var jsonData = await apiManager.getAPICall(
        isToken: true, url: '${adminUrl}get-all-piano-category');
    var response = PianoGetAllCategoryModel.fromJson(jsonData);
    return response;
  }

  //filter piano category
  Future<FilterPianoModel> filterPianoAPICall(
      {required String id, required bool isLoaderShow}) async {
    var jsonData = await apiManager.postAPICall(
        isToken: true,
        url: '${adminUrl}piano-category-filter',
        params: {"id": id},
        isLoaderShow: isLoaderShow);
    var response = FilterPianoModel.fromJson(jsonData);
    return response;
  }
  
  //********************** concerts hall data api call **********************//

  Future<ConcertHallModel> concertHallDataAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-all-concert-rentals',
    );
    var response = ConcertHallModel.fromJson(jsonData);
    return response;
  }

  // concert hall booked
  Future<ConcertBookUserModel> getConcertBookUserAPICall(
      {bool isLoaderShow = true, required String userId}) async {
    var jsonData = await apiManager.getAPICall(
        isToken: true,
        url: '${adminUrl}concert-book-user/$userId',
        isLoaderShow: isLoaderShow);
    var response = ConcertBookUserModel.fromJson(jsonData);
    return response;
  }

  //concert hall are canceling
  Future<CancelConcertBookModel> concertbookingCancelApiCall({
    required String userID,
    required String bookingID,
  }) async {
    var jsonData = await apiManager.postAPICall(
      url: '${adminUrl}cancel-concert-book',
      params: {
        "booking_id": bookingID,
        "user_id": userID,
      },
    );

    var response = CancelConcertBookModel.fromJson(jsonData);
    return response;
  }

  //********************** piano services data api call **********************//

  Future<PianoServicesModel> pianoServicesDataAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-piano-service',
    );
    var response = PianoServicesModel.fromJson(jsonData);
    return response;
  }

  //********************** Get All Concert Category api call **********************//

  Future<GetAllConcertCategoryModel> getAllConcertCategoryAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-all-concert-category',
    );
    var response = GetAllConcertCategoryModel.fromJson(jsonData);
    return response;
  }

  //********************** events & concerts data api call **********************//

  Future<EventResponseModel> eventsDataAPICall(
      {bool isLoaderShow = true}) async {
    var jsonData = await apiManager.getAPICall(
        isToken: true,
        url: '${adminUrl}get-all-event-concert',
        isLoaderShow: isLoaderShow);
    var response = EventResponseModel.fromJson(jsonData);
    return response;
  }

//********************** Banner data api call **********************//

  Future<GetBannerModel> getBannerAPICall({bool isLoaderShow = true}) async {
    var jsonData = await apiManager.getAPICall(
        isToken: true,
        url: '${adminUrl}get-banner',
        isLoaderShow: isLoaderShow);
    var response = GetBannerModel.fromJson(jsonData);
    return response;
  }

//********************** Banner data api call **********************//

  Future<GetPackageModel> getPackageAPICall({bool isLoaderShow = false}) async {
    var jsonData = await apiManager.getAPICall(
      isToken: false,
      url: '${adminUrl}get-wallet',
      isLoaderShow: isLoaderShow,
    );
    var response = GetPackageModel.fromJson(jsonData);
    return response;
  }

//********************** piano Type data api call **********************//

  Future<GetPianoTypeModel> getpianoTypeAPICall(
      {bool isLoaderShow = true}) async {
    var jsonData = await apiManager.getAPICall(
        isToken: true,
        url: '${adminUrl}get-pianoType',
        isLoaderShow: isLoaderShow);
    var response = GetPianoTypeModel.fromJson(jsonData);
    return response;
  }

//********************** Event Book User data api call **********************//

  Future<EventBookUserModel> getEventBookUserAPICall(
      {bool isLoaderShow = true, required String userId}) async {
    var jsonData = await apiManager.getAPICall(
        isToken: false,
        url: '${adminUrl}event-book-user/$userId',
        isLoaderShow: isLoaderShow);
    var response = EventBookUserModel.fromJson(jsonData);
    return response;
  }
}
