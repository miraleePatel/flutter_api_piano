// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

class EventResponseModel {
  int? status;
  String? message;
  List<EventData>? data;
  int? count;
  int? perPage;
  int? page;
  int? paginationValue;

  EventResponseModel({this.status, this.message, this.data, this.count, this.perPage, this.page, this.paginationValue});

  EventResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EventData>[];
      json['data'].forEach((v) {
        data!.add(new EventData.fromJson(v));
      });
    }
    count = json['count'];
    perPage = json['perPage'];
    page = json['page'];
    paginationValue = json['paginationValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['perPage'] = this.perPage;
    data['page'] = this.page;
    data['paginationValue'] = this.paginationValue;
    return data;
  }
}

class EventData {
  String? sId;
  String? name;
  String? venue;
  String? date;
  String? time;
  String? ticketType;
  int? ticketSize;
  int? remainingTicket;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? desc;
  String? terms;
  String? artist;
  String? file;
  int? ticketPrice;
  String? entryTime;

  EventData(
      {this.sId,
      this.name,
      this.venue,
      this.date,
      this.time,
      this.ticketType,
      this.ticketSize,
      this.remainingTicket,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.desc,
      this.terms,
      this.artist,
      this.file,
      this.ticketPrice,
      this.entryTime});

  EventData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    venue = json['venue'];
    date = json['date'];
    time = json['time'];
    ticketType = json['ticket_type'];
    ticketSize = json['ticket_size'];
    remainingTicket = json['remaining_ticket'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    desc = json['desc'];
    terms = json['terms'];
    artist = json['artist'];
    file = json['file'];
    ticketPrice = json['ticket_price'];
    entryTime = json['entry_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['venue'] = this.venue;
    data['date'] = this.date;
    data['time'] = this.time;
    data['ticket_type'] = this.ticketType;
    data['ticket_size'] = this.ticketSize;
    data['remaining_ticket'] = this.remainingTicket;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['desc'] = this.desc;
    data['terms'] = this.terms;
    data['artist'] = this.artist;
    data['file'] = this.file;
    data['ticket_price'] = this.ticketPrice;
    data['entry_time'] = this.entryTime;
    return data;
  }
}
