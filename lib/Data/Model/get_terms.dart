// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class GetTermsConditionsModel {
  int? status;
  String? message;
  String? data;

  GetTermsConditionsModel({this.status, this.message, this.data});

  GetTermsConditionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
