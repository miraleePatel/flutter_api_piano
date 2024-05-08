// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class CurrentUserModel {
  int? status;
  String? message;

  CurrentUserModel({this.status, this.message});

  CurrentUserModel.fromJson(Map<String, dynamic> json) {
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