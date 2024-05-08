// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class StudioBookUserModel {
  int? status;
  String? message;
  String? terms;
  List<StudioBookUserData>? data;

  StudioBookUserModel({this.status, this.message, this.terms, this.data});

  StudioBookUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    terms = json['terms'];
    if (json['data'] != null) {
      data = <StudioBookUserData>[];
      json['data'].forEach((v) {
        data!.add(new StudioBookUserData.fromJson(v));
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

class StudioBookUserData {
  String? sId;
  String? name;
  String? address;
  int? hourlyRate;
  String? file;
  String? desc;
  String? bookingId;
  String? bookDate;
  List<String>? timeSlot;
  String? bookPlan;
  bool? cancelBooking;

  StudioBookUserData(
      {this.sId,
      this.name,
      this.address,
      this.hourlyRate,
      this.file,
      this.desc,
      this.bookingId,
      this.bookDate,
      this.timeSlot,
      this.bookPlan,
      this.cancelBooking});

  StudioBookUserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    hourlyRate = json['hourlyRate'];
    file = json['file'];
    desc = json['desc'];
    bookingId = json['booking_id'];
    bookDate = json['book_date'];
    timeSlot = json['time_slot'].cast<String>();
    bookPlan = json['book_plan'];
    cancelBooking = json['cancel_booking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['hourlyRate'] = this.hourlyRate;
    data['file'] = this.file;
    data['desc'] = this.desc;
    data['booking_id'] = this.bookingId;
    data['book_date'] = this.bookDate;
    data['time_slot'] = this.timeSlot;
    data['book_plan'] = this.bookPlan;
    data['cancel_booking'] = this.cancelBooking;
    return data;
  }
}