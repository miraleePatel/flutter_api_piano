// ignore_for_file: unnecessary_new, prefer_collection_literals

class PaymentResponceModel {
  int? status;
  String? message;

  PaymentResponceModel({this.status, this.message});

  PaymentResponceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
