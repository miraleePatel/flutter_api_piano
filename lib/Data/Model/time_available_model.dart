// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class TimeAvailableModel {
  int? status;
  List<String>? data;

  TimeAvailableModel({this.status, this.data});

  TimeAvailableModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
