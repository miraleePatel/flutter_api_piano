// ignore_for_file: non_constant_identifier_names
import 'package:piano_project/Data/Model/studio_booking_model.dart';

import '../Data/Api/api_manager.dart';
import '../Data/Api/post_api_manager.dart';
import '../Data/Model/concert_hall_booking_model.dart';
import '../Data/Model/event_booking_response_model.dart';
import '../Data/Model/studio_wallet_recharge_model.dart';
import '../Data/Model/time_available_model.dart';
import '../Utils/string_constants.dart';

class BookingRepository {
  final APIManager apiManager;
  final PostAPIManager postAPIManager;

  BookingRepository(this.apiManager, this.postAPIManager);

  //********************** booking api call **********************//

  Future<TimeAvailableModel> timeAvalibaleAPICall({required String id, required String date}) async {
    var jsonData = await apiManager.postAPICall(
      url: '${adminUrl}booking-available',
      params: {"id": id, "date": date},
    );
    var response = TimeAvailableModel.fromJson(jsonData);
    return response;
  }
//********************** Event Booking api call **********************//

  Future<EventBookingResponseModel> eventTicBookAPICall({
    required String userId,
    required String eventId,
    required int quantity,
    required String payment,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}event-concert-booking',
      params: {"user_id": userId, "event_id": eventId, "quantity": quantity, "payment": payment},
    );
    var response = EventBookingResponseModel.fromJson(jsonData);

    return response;
  }
//********************** concert hall Booking api call **********************//

  Future<ConcertHallBookingModel> concerthallBookAPICall({
    required String userId,
    required String concertId,
    required List timeslot,
    required String date,
    Map? concertBookingDetail,
    required String payment,
    required String plan,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}concert-hall-booking',
      params: {
        "user_id": userId,
        "concert_id": concertId,
        "timeSlot": timeslot,
        "date": date,
        "concertBookingDetail": concertBookingDetail,
        "payment": payment,
        "plan": plan,
      },
    );
    var response = ConcertHallBookingModel.fromJson(jsonData);

    return response;
  }

  //********************** studio Booking api call **********************//

  Future<StudioBookingModel> studioBookAPICall({
    required String userId,
    required String studioID,
    List? timeslot,
    String? walletId,
    String? date,
    required String plan,
    required String payment,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}studio-booking',
      params: {"user_id": userId, "studio_id": studioID, "timeSlot": timeslot, "wallet_id": walletId, "date": date, "plan": plan, "payment": payment},
    );
    var response = StudioBookingModel.fromJson(jsonData);

    return response;
  }

  //********************** Tim Slot api call **********************//

  // concert time slot api
  Future<TimeAvailableModel> TimeSlotAPICall({
    required String date,
    required String currentdatetime,
    required String Id,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}available-time/$Id',
      params: {
        "date": date,
        "currentDateTime": currentdatetime,
      },
    );
    var response = TimeAvailableModel.fromJson(jsonData);

    return response;
  }

  // studio time slot api
  Future<TimeAvailableModel> StudioTimeSlotAPICall({
    required String date,
    required String currentdatetime,
    required String Id,
    required String model,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}available-time/$Id',
      params: {"date": date, "currentDateTime": currentdatetime, "model": model},
    );
    var response = TimeAvailableModel.fromJson(jsonData);

    return response;
  }

  //********************** wallet balance api call **********************//

  Future<StudioWalletRechargeModel> studioWalletRechargeAPICall({
    required String userId,
    required String walletId,
    required String hour,
    required int price,
    required String payment,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}studio-wallet-recharge',
      params: {"user_id": userId, "wallet_id": walletId, "hour": hour, "price": price, "payment": payment},
    );
    var response = StudioWalletRechargeModel.fromJson(jsonData);

    return response;
  }
}
