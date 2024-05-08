// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, unnecessary_new, unnecessary_this, prefer_collection_literals
class StudioRentalModel {
  int? status;
  String? message;
  List<StudioData>? data;
  int? count;
  int? perPage;
  int? page;
  Null? paginationValue;

  StudioRentalModel(
      {this.status,
        this.message,
        this.data,
        this.count,
        this.perPage,
        this.page,
        this.paginationValue});

  StudioRentalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudioData>[];
      json['data'].forEach((v) {
        data!.add(new StudioData.fromJson(v));
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

class StudioData {
  String? sId;
  String? name;
  String? address;
  int? hourlyRate;
  int? for10Classes;
  String? file;
  String? desc;
  List<Categories>? categories;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? dimension;
  List<String>? bookSlot;
  String? terms;

  StudioData(
      {this.sId,
        this.name,
        this.address,
        this.hourlyRate,
        this.for10Classes,
        this.file,
        this.desc,
        this.categories,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.dimension,
        this.bookSlot,
        this.terms});

  StudioData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    hourlyRate = json['hourlyRate'];
    for10Classes = json['for_10_classes'];
    file = json['file'];
    desc = json['desc'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    dimension = json['dimension'];
    if (json['book_slot'] != null) {
    bookSlot = json['book_slot'].cast<String>();}
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['hourlyRate'] = this.hourlyRate;
    data['for_10_classes'] = this.for10Classes;
    data['file'] = this.file;
    data['desc'] = this.desc;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['dimension'] = this.dimension;
    data['book_slot'] = this.bookSlot;
    data['terms'] = this.terms;
    return data;
  }
}

class Categories {
  String? sId;
  String? name;
  String? file;
  String? desc;

  Categories({this.sId, this.name, this.file, this.desc});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    file = json['file'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['file'] = this.file;
    data['desc'] = this.desc;
    return data;
  }
}
