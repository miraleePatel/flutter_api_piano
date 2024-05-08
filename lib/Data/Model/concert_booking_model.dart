// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class ConcertBookingModel {
  String? userId;
  String? concertId;
  List<String>? timeSlot;
  String? date;
  ConcertBookingDetail? concertBookingDetail;
  String? plan;

  ConcertBookingModel(
      {this.userId,
      this.concertId,
      this.timeSlot,
      this.date,
      this.concertBookingDetail,
      this.plan});

  ConcertBookingModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    concertId = json['concert_id'];
    timeSlot = json['timeSlot'].cast<String>();
    date = json['date'];
    concertBookingDetail = json['concertBookingDetail'] != null
        ? new ConcertBookingDetail.fromJson(json['concertBookingDetail'])
        : null;
    plan = json['plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['concert_id'] = this.concertId;
    data['timeSlot'] = this.timeSlot;
    data['date'] = this.date;
    if (this.concertBookingDetail != null) {
      data['concertBookingDetail'] = this.concertBookingDetail!.toJson();
    }
    data['plan'] = this.plan;
    return data;
  }
}

class ConcertBookingDetail {
  String? schoolName;
  String? teachersName;
  String? numbersOfPerformers;
  String? numbersOfGuests;

  ConcertBookingDetail(
      {this.schoolName,
      this.teachersName,
      this.numbersOfPerformers,
      this.numbersOfGuests});

  ConcertBookingDetail.fromJson(Map<String, dynamic> json) {
    schoolName = json['school_name'];
    teachersName = json['teachers_name'];
    numbersOfPerformers = json['numbers_of_performers'];
    numbersOfGuests = json['numbers_of_guests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['school_name'] = this.schoolName;
    data['teachers_name'] = this.teachersName;
    data['numbers_of_performers'] = this.numbersOfPerformers;
    data['numbers_of_guests'] = this.numbersOfGuests;
    return data;
  }
}
