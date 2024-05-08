// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class ForgotPasswordModel {
  int? status;
  String? message;

  ForgotPasswordModel({this.status, this.message});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}