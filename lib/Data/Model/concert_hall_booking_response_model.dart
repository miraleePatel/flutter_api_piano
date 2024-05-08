// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ConcertBookUserModel {
  int? status;
  String? message;
  String? terms;
  List<ConcertBookUserData>? data;

  ConcertBookUserModel({this.status, this.message, this.terms, this.data});

  ConcertBookUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    terms = json['terms'];
    if (json['data'] != null) {
      data = <ConcertBookUserData>[];
      json['data'].forEach((v) {
        data!.add(new ConcertBookUserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['terms'] = this.terms;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConcertBookUserData {
  String? sId;
  String? file;
  String? name;
  String? desc;
  int? price;
  String? priceDetail;
  String? bookingId;
  String? bookDate;
  List<String>? timeSlot;
  bool? cancelBooking;

  ConcertBookUserData(
      {this.sId,
      this.file,
      this.name,
      this.desc,
      this.price,
      this.priceDetail,
      this.bookingId,
      this.bookDate,
      this.timeSlot,
      this.cancelBooking});

  ConcertBookUserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    priceDetail = json['price_detail'];
    bookingId = json['booking_id'];
    bookDate = json['book_date'];
    timeSlot = json['time_slot'].cast<String>();
    cancelBooking = json['cancel_booking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['file'] = this.file;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['price_detail'] = this.priceDetail;
    data['booking_id'] = this.bookingId;
    data['book_date'] = this.bookDate;
    data['time_slot'] = this.timeSlot;
    data['cancel_booking'] = this.cancelBooking;
    return data;
  }
}