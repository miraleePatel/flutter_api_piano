// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class FaqResponseModel {
  int? status;
  String? message;
  List<FaqData>? data;

  FaqResponseModel({this.status, this.message, this.data});

  FaqResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FaqData>[];
      json['data'].forEach((v) {
        data!.add(new FaqData.fromJson(v));
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

class FaqData {
  String? sId;
  String? file;
  String? title;
  String? desc;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FaqData(
      {this.sId,
      this.file,
      this.title,
      this.desc,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FaqData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
    title = json['title'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['file'] = this.file;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
