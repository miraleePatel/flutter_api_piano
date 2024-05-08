class ContactUsModel {
  int? status;
  String? message;
  List<ContactUsData>? data;

  ContactUsModel({this.status, this.message, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContactUsData>[];
      json['data'].forEach((v) {
        data!.add(ContactUsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactUsData {
  String? sId;
  MainShowroom? mainShowroom;
  MainShowroom? steinwayLounge;
  String? usedPianoShowroom;
  SalesEnquiry? salesEnquiry;
  SalesEnquiry? rentalEnquiry;
  HeadQuarter? headQuarter;
  int? iV;
  SalesEnquiry? serviceEnquiry;
  String? telegramNo;
  String? whatsAppNo;

  ContactUsData({
    this.sId,
    this.mainShowroom,
    this.steinwayLounge,
    this.usedPianoShowroom,
    this.salesEnquiry,
    this.rentalEnquiry,
    this.headQuarter,
    this.iV,
    this.serviceEnquiry,
    this.telegramNo,
    this.whatsAppNo,
  });

  ContactUsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mainShowroom = json['main_showroom'] != null ? MainShowroom.fromJson(json['main_showroom']) : null;
    steinwayLounge = json['steinway_lounge'] != null ? MainShowroom.fromJson(json['steinway_lounge']) : null;
    usedPianoShowroom = json['used_piano_showroom'];
    salesEnquiry = json['sales_enquiry'] != null ? SalesEnquiry.fromJson(json['sales_enquiry']) : null;
    rentalEnquiry = json['rental_enquiry'] != null ? SalesEnquiry.fromJson(json['rental_enquiry']) : null;
    headQuarter = json['head_quarter'] != null ? HeadQuarter.fromJson(json['head_quarter']) : null;
    iV = json['__v'];
    serviceEnquiry = json['service_enquiry'] != null ? SalesEnquiry.fromJson(json['service_enquiry']) : null;

    telegramNo = json['telegram_no'];
    whatsAppNo = json['whatsApp_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (mainShowroom != null) {
      data['main_showroom'] = mainShowroom!.toJson();
    }
    if (steinwayLounge != null) {
      data['steinway_lounge'] = steinwayLounge!.toJson();
    }
    data['used_piano_showroom'] = usedPianoShowroom;
    if (salesEnquiry != null) {
      data['sales_enquiry'] = salesEnquiry!.toJson();
    }
    if (rentalEnquiry != null) {
      data['rental_enquiry'] = rentalEnquiry!.toJson();
    }
    if (headQuarter != null) {
      data['head_quarter'] = headQuarter!.toJson();
    }
    data['__v'] = iV;
    if (serviceEnquiry != null) {
      data['service_enquiry'] = serviceEnquiry!.toJson();
    }

    data['telegram_no'] = this.telegramNo;
    data['whatsApp_no'] = this.whatsAppNo;
    return data;
  }
}

class MainShowroom {
  String? address;
  String? phoneNo;

  MainShowroom({this.address, this.phoneNo});

  MainShowroom.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['phone_no'] = phoneNo;
    return data;
  }
}

class SalesEnquiry {
  String? phoneNo;
  String? email;

  SalesEnquiry({this.phoneNo, this.email});

  SalesEnquiry.fromJson(Map<String, dynamic> json) {
    phoneNo = json['phone_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_no'] = phoneNo;
    data['email'] = email;
    return data;
  }
}

class HeadQuarter {
  String? name;
  String? phoneNo;
  String? email;

  HeadQuarter({this.name, this.phoneNo, this.email});

  HeadQuarter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNo = json['phone_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_no'] = phoneNo;
    data['email'] = email;
    return data;
  }
}
