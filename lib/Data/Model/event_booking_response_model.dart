// ignore_for_file: unnecessary_new, prefer_collection_literals

class EventBookingResponseModel {
  int? status;
  String? message;
  String? paymentUrl;
  String? bookingId;

  EventBookingResponseModel(
      {this.status, this.message, this.paymentUrl, this.bookingId});

  EventBookingResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    paymentUrl = json['payment_url'];
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['payment_url'] = paymentUrl;
    data['booking_id'] = bookingId;
    return data;
  }
}
