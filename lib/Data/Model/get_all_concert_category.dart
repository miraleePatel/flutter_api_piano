// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class GetAllConcertCategoryModel {
  int? status;
  String? message;
  List<GetAllConcertCategory>? data;

  GetAllConcertCategoryModel({this.status, this.message, this.data});

  GetAllConcertCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllConcertCategory>[];
      json['data'].forEach((v) {
        data!.add(new GetAllConcertCategory.fromJson(v));
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

class GetAllConcertCategory {
  String? sId;
  String? file;
  String? name;
  String? desc;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? note;
  int? price;
  String? priceDetail;
  String? terms;

  GetAllConcertCategory(
      {this.sId,
      this.file,
      this.name,
      this.desc,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.note,
      this.price,
      this.priceDetail,
      this.terms});

  GetAllConcertCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
    name = json['name'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    note = json['note'];
    price = json['price'];
    priceDetail = json['price_detail'];
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['file'] = this.file;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['note'] = this.note;
    data['price'] = this.price;
    data['price_detail'] = this.priceDetail;
    data['terms'] = this.terms;
    return data;
  }
}
