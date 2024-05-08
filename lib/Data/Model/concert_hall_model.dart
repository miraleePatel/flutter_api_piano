// ignore_for_file: unnecessary_new, unnecessary_question_mark, prefer_void_to_null, unnecessary_this, prefer_collection_literals

class ConcertHallModel {
  int? status;
  String? message;
  List<ConcertData>? data;
  int? count;
  int? perPage;
  int? page;
  Null? paginationValue;

  ConcertHallModel(
      {this.status,
      this.message,
      this.data,
      this.count,
      this.perPage,
      this.page,
      this.paginationValue});

  ConcertHallModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ConcertData>[];
      json['data'].forEach((v) {
        data!.add(new ConcertData.fromJson(v));
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

class ConcertData {
  String? sId;
  String? name;
  String? address;
  String? introduction;
  String? file;
  Summary? summary;
  List<Categories>? categories;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ConcertData(
      {this.sId,
      this.name,
      this.address,
      this.introduction,
      this.file,
      this.summary,
      this.categories,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ConcertData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    introduction = json['introduction'];
    file = json['file'];
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
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
    data['name'] = this.name;
    data['address'] = this.address;
    data['introduction'] = this.introduction;
    data['file'] = this.file;
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Summary {
  String? title;
  String? desc;

  Summary({this.title, this.desc});

  Summary.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    return data;
  }
}

class Categories {
  String? sId;
  String? file;
  String? name;
  String? desc;

  Categories({this.sId, this.file, this.name, this.desc});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['file'] = this.file;
    data['name'] = this.name;
    data['desc'] = this.desc;
    return data;
  }
}

