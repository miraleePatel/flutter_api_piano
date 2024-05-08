// ignore_for_file: non_constant_identifier_names
import '../Data/Api/api_manager.dart';
import '../Data/Api/post_api_manager.dart';
import '../Data/Model/apple_payment_model.dart';
import '../Data/Model/concert_pay_details_model.dart';
import '../Data/Model/event_concert_payment_info_model.dart';
import '../Data/Model/payment_info_model.dart';
import '../Data/Model/payment_responce_model.dart';
import '../Utils/string_constants.dart';

class PaymentRepository {
  final APIManager apiManager;
  final PostAPIManager postAPIManager;

  PaymentRepository(this.apiManager, this.postAPIManager);

  //********************** Payment Check api call **********************//

  Future<PaymentResponceModel> paymentResponceAPICall({
    required String bookingId,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}check-payment',
      params: {"booking_id": bookingId},
    );
    var response = PaymentResponceModel.fromJson(jsonData);
    return response;
  }

  //********************** Payment information api call **********************//

  //studio payment information
  Future<PaymentInfoModel> paymentInfoAPICall({
    required String userId,
    required String studioID,
    List? timeslot,
    String? date,
    required String plan,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}payment-info',
      params: {
        "user_id": userId,
        "studio_id": studioID,
        "timeSlot": timeslot,
        "date": date,
        "plan": plan
      },
    );
    var response = PaymentInfoModel.fromJson(jsonData);

    return response;
  }

  //concert payment information
  Future<ConcertPayDetailsModel> concertPayInfoAPICall({
    required String userId,
    required String concertID,
    List? timeslot,
    String? date,
    required String plan,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}concert-payment-info',
      params: {
        "user_id": userId,
        "concert_id": concertID,
        "timeSlot": timeslot,
        "date": date,
         "plan": plan
      },
    );
    var response = ConcertPayDetailsModel.fromJson(jsonData);

    return response;
  }

  //event & concert information
  Future<EventConcertPaymentInfoModel> eventPaymentInfoAPICall({
    required String userId,
    required String eventId,
    required int quantity,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}event-payment-info',
      params: {
        "user_id": userId,
        "event_id": eventId,
        "quantity": quantity,
      },
    );
    var response = EventConcertPaymentInfoModel.fromJson(jsonData);
    return response;
  }

  //********************** Payment Responce api call **********************//

  Future<ApplePaymentModel> applePaymentAPICall({
    required String paymentStatus,
    required String transactionId,
    required String paymentMethod,
    required String cardType,
    required String paymentDescription,
    required String amount,
    required String bookingId,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${adminUrl}applepay-response',
      params: {
        "payment_status": paymentStatus,
        "transaction_id": transactionId,
        "payment_info": {
          "payment_method": paymentMethod,
          "card_type": cardType,
          "payment_description": paymentDescription
        },
        "amount": amount,
        "booking_id": bookingId
      },
    );
    var response = ApplePaymentModel.fromJson(jsonData);
    return response;
  }
}
