class EventConcertPaymentInfoModel {
  int? status;
  String? message;
  EventPaymentData? data;

  EventConcertPaymentInfoModel({this.status, this.message, this.data});

  EventConcertPaymentInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? EventPaymentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EventPaymentData {
  String? name;
  String? venue;
  String? date;
  String? time;
  String? ticketType;
  int? ticketQuantity;
  int? totalAmount;
  String? entryTime;

  EventPaymentData({this.name, this.venue, this.date, this.time, this.ticketType, this.ticketQuantity, this.totalAmount, this.entryTime});

  EventPaymentData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    venue = json['venue'];
    date = json['date'];
    time = json['time'];
    ticketType = json['ticket_type'];
    ticketQuantity = json['ticket_quantity'];
    totalAmount = json['total_amount'];
    entryTime = json['entry_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['venue'] = venue;
    data['date'] = date;
    data['time'] = time;
    data['ticket_type'] = ticketType;
    data['ticket_quantity'] = ticketQuantity;
    data['total_amount'] = totalAmount;
    data['entry_time'] = this.entryTime;
    return data;
  }
}
