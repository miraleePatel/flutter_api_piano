// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class StudioWalletRechargeModel {
  int? status;
  String? message;
  String? paymentUrl;
  String? bookingId;
  int? price;

  StudioWalletRechargeModel({this.status, this.message, this.paymentUrl, this.bookingId, this.price});

  StudioWalletRechargeModel.fromJson(Map<String, dynamic> json) {
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
