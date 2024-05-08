// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this, unnecessary_question_mark, prefer_void_to_null

class PianoRentalModel {
  int? status;
  String? message;
  List<PianoData>? data;
  int? count;
  int? perPage;
  int? page;
  Null? paginationValue;

  PianoRentalModel(
      {this.status,
      this.message,
      this.data,
      this.count,
      this.perPage,
      this.page,
      this.paginationValue});

  PianoRentalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PianoData>[];
      json['data'].forEach((v) {
        data!.add(new PianoData.fromJson(v));
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

class PianoData {
  String? sId;
  String? heading;
  String? title;
  String? desc;
  String? brand;
  String? model;
  String? color;
  String? dimension;
  String? file;
  List<Categories>? categories;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PianoData(
      {this.sId,
      this.heading,
      this.title,
      this.desc,
      this.brand,
      this.model,
      this.color,
      this.dimension,
      this.file,
      this.categories,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PianoData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    heading = json['heading'];
    title = json['title'];
    desc = json['desc'];
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    dimension = json['dimension'];
    file = json['file'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['heading'] = this.heading;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['color'] = this.color;
    data['dimension'] = this.dimension;
    data['file'] = this.file;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Categories {
  String? sId;
  String? name;

  Categories({this.sId, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}