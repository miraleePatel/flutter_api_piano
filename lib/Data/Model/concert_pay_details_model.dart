// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ConcertPayDetailsModel {
  int? status;
  String? message;
  ConcertPayData? data;

  ConcertPayDetailsModel({this.status, this.message, this.data});

  ConcertPayDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new ConcertPayData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ConcertPayData {
  String? concertHallName;
  String? date;
  int? totalAmount;
  int? walletBalance;
  List<String>? timeSlot;
  String? plan;

  ConcertPayData({
    this.concertHallName,
    this.date,
    this.totalAmount,
    this.walletBalance,
    this.timeSlot,
    this.plan,
  });

  ConcertPayData.fromJson(Map<String, dynamic> json) {
    concertHallName = json['Concert_Hall_name'];
    date = json['date'];
    totalAmount = json['total_amount'];
    walletBalance = json['wallet_balance'];
    plan = json['plan'];
    timeSlot = json['timeSlot'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Concert_Hall_name'] = this.concertHallName;
    data['date'] = this.date;
    data['total_amount'] = this.totalAmount;
    data['wallet_balance'] = this.walletBalance;
    data['plan'] = this.plan;
    data['timeSlot'] = this.timeSlot;
    return data;
  }
}
