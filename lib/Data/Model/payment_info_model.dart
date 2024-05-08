// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class PaymentInfoModel {
  int? status;
  String? message;
  PaymentInfoData? data;

  PaymentInfoModel({this.status, this.message, this.data});

  PaymentInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PaymentInfoData.fromJson(json['data']) : null;
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

class PaymentInfoData {
  String? studioName;
  WalletType? walletType;
  String? date;
  String? plan;
  int? remainingHour;
  int? totalAmount;
  int? amount;
  String? discount;
  List<String>? timeSlot;

  PaymentInfoData(
      {this.studioName, this.walletType, this.date, this.plan, this.remainingHour, this.totalAmount, this.amount, this.discount, this.timeSlot});

  PaymentInfoData.fromJson(Map<String, dynamic> json) {
    studioName = json['studio_name'];
    walletType = json['wallet_type'] != null ? new WalletType.fromJson(json['wallet_type']) : null;
    date = json['date'];
    plan = json['plan'];
    remainingHour = json['remaining_hour'];
    totalAmount = json['total_amount'];
    amount = json['amount'];
    discount = json['discount'];
    timeSlot = json['timeSlot'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studio_name'] = this.studioName;
    if (this.walletType != null) {
      data['wallet_type'] = this.walletType!.toJson();
    }
    data['date'] = this.date;
    data['plan'] = this.plan;
    data['remaining_hour'] = this.remainingHour;
    data['total_amount'] = this.totalAmount;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['timeSlot'] = this.timeSlot;
    return data;
  }
}

class WalletType {
  String? sId;
  String? walletName;

  WalletType({this.sId, this.walletName});

  WalletType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    walletName = json['wallet_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['wallet_name'] = this.walletName;
    return data;
  }
}
