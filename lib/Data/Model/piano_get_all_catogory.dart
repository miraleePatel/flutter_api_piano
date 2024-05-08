class PianoGetAllCategoryModel {
  int? status;
  String? message;
  List<PianoGetAllCategory>? data;

  PianoGetAllCategoryModel({this.status, this.message, this.data});

  PianoGetAllCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = < PianoGetAllCategory>[];
      json['data'].forEach((v) {
        data!.add(PianoGetAllCategory.fromJson(v));
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

class  PianoGetAllCategory {
  String? sId;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PianoGetAllCategory({this.sId, this.name, this.createdAt, this.updatedAt, this.iV});

  PianoGetAllCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
