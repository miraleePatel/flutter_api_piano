// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class CancelConcertBookModel {
  int? status;
  String? message;

  CancelConcertBookModel({this.status, this.message});

  CancelConcertBookModel.fromJson(Map<String, dynamic> json) {
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