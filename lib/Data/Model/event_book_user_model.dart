// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class EventBookUserModel {
  int? status;
  String? message;
  List<BookUserData>? data;

  EventBookUserModel({this.status, this.message, this.data});

  EventBookUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookUserData>[];
      json['data'].forEach((v) {
        data!.add(new BookUserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookUserData {
  String? sId;
  String? name;
  String? artist;
  String? venue;
  String? date;
  String? time;
  int? ticketSize;
  int? remainingTicket;
  List<TicketBuyer>? ticketBuyer;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? file;
  String? desc;
  String? ticketType;
  int? userTicketBuy;
  int? ticketPrice;
  String? entryTime;

  BookUserData(
      {this.sId,
      this.name,
      this.artist,
      this.venue,
      this.date,
      this.time,
      this.ticketSize,
      this.remainingTicket,
      this.ticketBuyer,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.file,
      this.desc,
      this.ticketType,
      this.userTicketBuy,
      this.ticketPrice,
      this.entryTime});

  BookUserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    artist = json['artist'];
    venue = json['venue'];
    date = json['date'];
    time = json['time'];
    ticketSize = json['ticket_size'];
    remainingTicket = json['remaining_ticket'];
    if (json['ticket_buyer'] != null) {
      ticketBuyer = <TicketBuyer>[];
      json['ticket_buyer'].forEach((v) {
        ticketBuyer!.add(new TicketBuyer.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    file = json['file'];
    desc = json['desc'];
    ticketType = json['ticket_type'];
    userTicketBuy = json['user_ticket_buy'];
    ticketPrice = json['ticket_price'];
    entryTime = json['entry_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['artist'] = this.artist;
    data['venue'] = this.venue;
    data['date'] = this.date;
    data['time'] = this.time;
    data['ticket_size'] = this.ticketSize;
    data['remaining_ticket'] = this.remainingTicket;
    if (this.ticketBuyer != null) {
      data['ticket_buyer'] = this.ticketBuyer!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['file'] = this.file;
    data['desc'] = this.desc;
    data['ticket_type'] = this.ticketType;
    data['user_ticket_buy'] = this.userTicketBuy;
    data['ticket_price'] = this.ticketPrice;
    data['entry_time'] = this.entryTime;
    return data;
  }
}

class TicketBuyer {
  String? buyerId;
  int? ticketQuantity;
  String? sId;

  TicketBuyer({this.buyerId, this.ticketQuantity, this.sId});

  TicketBuyer.fromJson(Map<String, dynamic> json) {
    buyerId = json['buyer_id'];
    ticketQuantity = json['ticket_quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyer_id'] = this.buyerId;
    data['ticket_quantity'] = this.ticketQuantity;
    data['_id'] = this.sId;
    return data;
  }
}
