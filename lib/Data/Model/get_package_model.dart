// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class GetPackageModel {
  int? status;
  String? message;
  List<GetPackage>? data;

  GetPackageModel({this.status, this.message, this.data});

  GetPackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetPackage>[];
      json['data'].forEach((v) {
        data!.add(new GetPackage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPackage {
  String? sId;
  String? walletName;
  List<PackageDetail>? packageDetail;
  int? priceHourly;
  int? maxLimit;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? remainingWalletHour;

  GetPackage(
      {this.sId,
      this.walletName,
      this.packageDetail,
      this.priceHourly,
      this.maxLimit,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.remainingWalletHour});

  GetPackage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    walletName = json['wallet_name'];
    if (json['package_detail'] != null) {
      packageDetail = <PackageDetail>[];
      json['package_detail'].forEach((v) {
        packageDetail!.add(PackageDetail.fromJson(v));
      });
    }
    priceHourly = json['price_hourly'];
    maxLimit = json['maxLimit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    remainingWalletHour = json['remaining_wallet_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['wallet_name'] = walletName;
    if (packageDetail != null) {
      data['package_detail'] = packageDetail!.map((v) => v.toJson()).toList();
    }
    data['price_hourly'] = priceHourly;
    data['maxLimit'] = maxLimit;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['remaining_wallet_hour'] = remainingWalletHour;
    return data;
  }
}

class PackageDetail {
  String? packageName;
  String? packageLabel;
  int? packageHour;
  int? packageRate;
  String? sId;
  int? discount;

  PackageDetail({this.packageName, this.packageLabel, this.packageHour, this.packageRate, this.sId, this.discount});

  PackageDetail.fromJson(Map<String, dynamic> json) {
    packageName = json['package_name'];
    packageLabel = json['package_label'];
    packageHour = json['package_hour'];
    packageRate = json['package_rate'];
    sId = json['_id'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_name'] = this.packageName;
    data['package_label'] = this.packageLabel;
    data['package_hour'] = this.packageHour;
    data['package_rate'] = this.packageRate;
    data['_id'] = this.sId;
    data['discount'] = this.discount;
    return data;
  }
}
