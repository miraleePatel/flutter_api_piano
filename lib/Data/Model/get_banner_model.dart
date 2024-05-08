class GetBannerModel {
  int? status;
  String? message;
  List<BannerData>? data;

  GetBannerModel({
    this.status,
    this.message,
    this.data,
  });

  GetBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(BannerData.fromJson(v));
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

class BannerData {
  String? sId;
  String? banner;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? navigation;

  BannerData({this.sId, this.banner, this.createdAt, this.updatedAt, this.iV, this.navigation});

  BannerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    banner = json['banner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    navigation = json['navigation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['banner'] = banner;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['navigation'] = navigation;
    return data;
  }
}
