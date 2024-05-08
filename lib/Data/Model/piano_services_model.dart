
class PianoServicesModel {
  int? status;
  String? message;
  List<PianoSerData>? data;

  PianoServicesModel({this.status, this.message, this.data});

  PianoServicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PianoSerData>[];
      json['data'].forEach((v) {
        data!.add(PianoSerData.fromJson(v));
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

class PianoSerData {
  String? sId;
  String? name;
  String? file;
  String? desc;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? note;
  List<PriceDetail>? priceDetail;

  PianoSerData(
      {this.sId,
      this.name,
      this.file,
      this.desc,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.note,
      this.priceDetail});

  PianoSerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    file = json['file'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    note = json['note'];
    if (json['price_detail'] != null) {
      priceDetail = <PriceDetail>[];
      json['price_detail'].forEach((v) {
        priceDetail!.add(PriceDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['file'] = file;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['note'] = note;
    if (priceDetail != null) {
      data['price_detail'] = priceDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PriceDetail {
  String? detail;
  String? price;
  String? sId;

  PriceDetail({this.detail, this.price, this.sId});

  PriceDetail.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    data['price'] = price;
    data['_id'] = sId;
    return data;
  }
}
