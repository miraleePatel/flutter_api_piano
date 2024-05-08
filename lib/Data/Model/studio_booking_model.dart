// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class StudioBookingModel {
  int? status;
  String? message;
  String? paymentUrl;
  String? bookingId;
  int? price;

  StudioBookingModel({this.status, this.message, this.paymentUrl, this.bookingId, this.price});

  StudioBookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    paymentUrl = json['payment_url'];
    bookingId = json['booking_id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['payment_url'] = this.paymentUrl;
    data['booking_id'] = this.bookingId;
    data['price'] = this.price;
    return data;
  }
}
