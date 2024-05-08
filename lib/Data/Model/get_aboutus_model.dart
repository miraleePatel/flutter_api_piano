class GetAboutUsModel {
  int? status;
  String? message;
  AboutData? data;

  GetAboutUsModel({this.status, this.message, this.data});

  GetAboutUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AboutData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AboutData {
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? desc1;
  String? desc2;
  String? desc3;
  String? desc4;
  String? link;
  String? linkTitle;

  AboutData(
      {this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.desc1,
      this.desc2,
      this.desc3,
      this.desc4,
      this.link,
      this.linkTitle});

  AboutData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    desc1 = json['desc_1'];
    desc2 = json['desc_2'];
    desc3 = json['desc_3'];
    desc4 = json['desc_4'];
    link = json['link'];
    linkTitle = json['link_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['desc_1'] = desc1;
    data['desc_2'] = desc2;
    data['desc_3'] = desc3;
    data['desc_4'] = desc4;
    data['link'] = link;
    data['link_title'] = linkTitle;
    return data;
  }
}
