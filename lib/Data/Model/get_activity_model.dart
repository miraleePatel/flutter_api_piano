// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class GetActivityModel {
  int? status;
  String? message;
  ListData? data;

  GetActivityModel({this.status, this.message, this.data});

  GetActivityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ListData.fromJson(json['data']) : null;
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

class ListData {
  String? sId;
  String? userDetail;
  List<Activity>? activity;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Notification>? notification;

  ListData({this.sId, this.userDetail, this.activity, this.createdAt, this.updatedAt, this.iV, this.notification});

  ListData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userDetail = json['user_detail'];
    if (json['activity'] != null) {
      activity = <Activity>[];
      json['activity'].forEach((v) {
        activity!.add(Activity.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_detail'] = this.userDetail;
    if (this.activity != null) {
      data['activity'] = this.activity!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.notification != null) {
      data['notification'] = this.notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activity {
  String? title;
  EnquiryDetail? enquiryDetail;
  String? dateTime;
  String? sId;
  List<String>? bookSlot;
  BookingDetail? bookingDetail;

  Activity({this.title, this.enquiryDetail, this.dateTime, this.sId, this.bookingDetail});

  Activity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    enquiryDetail = json['enquiry_detail'] != null ? new EnquiryDetail.fromJson(json['enquiry_detail']) : null;
    dateTime = json['dateTime'];
    if (bookSlot != null) {
      bookSlot = json['book_slot'].cast<String>();
    }
    sId = json['_id'];
    bookingDetail = json['booking_detail'] != null ? new BookingDetail.fromJson(json['booking_detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (enquiryDetail != null) {
      data['enquiry_detail'] = enquiryDetail!.toJson();
    }
    data['dateTime'] = this.dateTime;
    data['_id'] = sId;
    data['book_slot'] = this.bookSlot;
    if (bookingDetail != null) {
      data['booking_detail'] = bookingDetail!.toJson();
    }
    return data;
  }
}

class EnquiryDetail {
  String? sId;
  int? enquiryId;
  String? userDetail;
  String? serviceType;
  String? serviceName;
  String? location;
  String? date;
  String? note;
  PianoService? pianoService;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EnquiryDetail(
      {this.sId,
      this.enquiryId,
      this.userDetail,
      this.serviceType,
      this.serviceName,
      this.location,
      this.date,
      this.note,
      this.pianoService,
      this.createdAt,
      this.updatedAt,
      this.iV});

  EnquiryDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    enquiryId = json['enquiry_id'];
    userDetail = json['user_detail'];
    serviceType = json['service_type'];
    serviceName = json['service_name'];
    location = json['location'];
    date = json['date'];
    note = json['note'];
    pianoService = json['piano_service'] != null ? new PianoService.fromJson(json['piano_service']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['enquiry_id'] = this.enquiryId;
    data['user_detail'] = this.userDetail;
    data['service_type'] = this.serviceType;
    data['service_name'] = this.serviceName;
    data['location'] = this.location;
    data['date'] = this.date;
    data['note'] = this.note;
    if (this.pianoService != null) {
      data['piano_service'] = this.pianoService!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PianoService {
  String? pianoType;
  String? pianoBrand;

  PianoService({this.pianoType, this.pianoBrand});

  PianoService.fromJson(Map<String, dynamic> json) {
    pianoType = json['piano_type'];
    pianoBrand = json['piano_brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['piano_type'] = this.pianoType;
    data['piano_brand'] = this.pianoBrand;
    return data;
  }
}

class BookingDetail {
  String? sId;
  List<String>? bookHourlyTimeSlot;
  BookedService? bookedService;
  int? ticketQuantity;
  bool? bookByTeacher;
  String? studioBookPlan;
  int? rechargeHour;
  int? studioWalletHour;
  List<Payment>? payment;
  String? bookDate;
  String? bookTime;

  BookingDetail(
      {this.sId,
      this.bookHourlyTimeSlot,
      this.bookedService,
      this.ticketQuantity,
      this.bookByTeacher,
      this.studioBookPlan,
      this.rechargeHour,
      this.studioWalletHour,
      this.payment,
      this.bookDate,
      this.bookTime});

  BookingDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookHourlyTimeSlot = json['book_hourly_time_slot'].cast<String>();
    bookedService = json['booked_service'] != null ? new BookedService.fromJson(json['booked_service']) : null;
    ticketQuantity = json['Ticket_quantity'];
    bookByTeacher = json['book_by_teacher'];
    studioBookPlan = json['studio_book_plan'];
    rechargeHour = json['recharge_hour'];
    studioWalletHour = json['studio_wallet_hour'];
    if (json['payment'] != null) {
      payment = <Payment>[];
      json['payment'].forEach((v) {
        payment!.add(new Payment.fromJson(v));
      });
    }
    bookDate = json['book_date'];
    bookTime = json['book_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['book_hourly_time_slot'] = this.bookHourlyTimeSlot;
    if (this.bookedService != null) {
      data['booked_service'] = this.bookedService!.toJson();
    }
    data['Ticket_quantity'] = this.ticketQuantity;
    data['book_by_teacher'] = this.bookByTeacher;
    data['studio_book_plan'] = this.studioBookPlan;
    data['recharge_hour'] = this.rechargeHour;
    data['studio_wallet_hour'] = this.studioWalletHour;
    if (this.payment != null) {
      data['payment'] = this.payment!.map((v) => v.toJson()).toList();
    }
    data['book_date'] = this.bookDate;
    data['book_time'] = this.bookTime;
    return data;
  }
}

class BookedService {
  String? externalModelType;
  String? serviceName;
  Service? service;

  BookedService({this.externalModelType, this.serviceName, this.service});

  BookedService.fromJson(Map<String, dynamic> json) {
    externalModelType = json['externalModelType'];
    serviceName = json['service_name'];
    service = json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['externalModelType'] = this.externalModelType;
    data['service_name'] = this.serviceName;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  String? sId;
  String? walletName;
  List<PackageDetail>? packageDetail;
  int? priceHourly;
  int? maxLimit;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isDisabled;
  String? name;
  String? artist;
  String? venue;
  String? date;
  String? file;
  String? time;
  String? desc;
  String? terms;
  String? ticketType;
  int? ticketPrice;
  int? ticketSize;
  int? remainingTicket;
  String? note;
  int? price;
  String? priceDetail;
  String? address;
  int? hourlyRate;
  int? for10Classes;
  List<String>? categories;
  String? dimension;
  int? for25Classes;
  int? for50Classes;
  String? walletType;

  Service(
      {this.sId,
      this.walletName,
      this.packageDetail,
      this.priceHourly,
      this.maxLimit,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isDisabled,
      this.name,
      this.artist,
      this.venue,
      this.date,
      this.file,
      this.time,
      this.desc,
      this.terms,
      this.ticketType,
      this.ticketPrice,
      this.ticketSize,
      this.remainingTicket,
      this.note,
      this.price,
      this.priceDetail,
      this.address,
      this.hourlyRate,
      this.for10Classes,
      this.categories,
      this.dimension,
      this.for25Classes,
      this.for50Classes,
      this.walletType});

  Service.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    walletName = json['wallet_name'];
    if (json['package_detail'] != null) {
      packageDetail = <PackageDetail>[];
      json['package_detail'].forEach((v) {
        packageDetail!.add(new PackageDetail.fromJson(v));
      });
    }
    priceHourly = json['price_hourly'];
    maxLimit = json['maxLimit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    isDisabled = json['is_disabled'];
    name = json['name'];
    artist = json['artist'];
    venue = json['venue'];
    date = json['date'];
    file = json['file'];
    time = json['time'];
    desc = json['desc'];
    terms = json['terms'];
    ticketType = json['ticket_type'];
    ticketPrice = json['ticket_price'];
    ticketSize = json['ticket_size'];
    remainingTicket = json['remaining_ticket'];
    note = json['note'];
    price = json['price'];
    priceDetail = json['price_detail'];
    address = json['address'];
    hourlyRate = json['hourlyRate'];
    for10Classes = json['for_10_classes'];
    if (categories != null) {
      categories = json['categories'].cast<String>();
    }
    dimension = json['dimension'];
    for25Classes = json['for_25_classes'];
    for50Classes = json['for_50_classes'];
    walletType = json['wallet_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['wallet_name'] = this.walletName;
    if (this.packageDetail != null) {
      data['package_detail'] = this.packageDetail!.map((v) => v.toJson()).toList();
    }
    data['price_hourly'] = this.priceHourly;
    data['maxLimit'] = this.maxLimit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['is_disabled'] = this.isDisabled;
    data['name'] = this.name;
    data['artist'] = this.artist;
    data['venue'] = this.venue;
    data['date'] = this.date;
    data['file'] = this.file;
    data['time'] = this.time;
    data['desc'] = this.desc;
    data['terms'] = this.terms;
    data['ticket_type'] = this.ticketType;
    data['ticket_price'] = this.ticketPrice;
    data['ticket_size'] = this.ticketSize;
    data['remaining_ticket'] = this.remainingTicket;
    data['note'] = this.note;
    data['price'] = this.price;
    data['price_detail'] = this.priceDetail;
    data['address'] = this.address;
    data['hourlyRate'] = this.hourlyRate;
    data['for_10_classes'] = this.for10Classes;
    data['categories'] = this.categories;
    data['dimension'] = this.dimension;
    data['for_25_classes'] = this.for25Classes;
    data['for_50_classes'] = this.for50Classes;
    data['wallet_type'] = this.walletType;
    return data;
  }
}

class PackageDetail {
  String? packageName;
  String? packageLabel;
  int? packageHour;
  int? packageRate;
  String? sId;

  PackageDetail({this.packageName, this.packageLabel, this.packageHour, this.packageRate, this.sId});

  PackageDetail.fromJson(Map<String, dynamic> json) {
    packageName = json['package_name'];
    packageLabel = json['package_label'];
    packageHour = json['package_hour'];
    packageRate = json['package_rate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_name'] = this.packageName;
    data['package_label'] = this.packageLabel;
    data['package_hour'] = this.packageHour;
    data['package_rate'] = this.packageRate;
    data['_id'] = this.sId;
    return data;
  }
}

class Payment {
  String? sId;
  String? paymentAmount;

  Payment({this.sId, this.paymentAmount});

  Payment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    paymentAmount = json['payment_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['payment_amount'] = this.paymentAmount;
    return data;
  }
}

class Notification {
  String? title;
  String? dateTime;
  String? sId;

  Notification({this.title, this.dateTime, this.sId});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dateTime = json['dateTime'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['dateTime'] = this.dateTime;
    data['_id'] = this.sId;
    return data;
  }
}
