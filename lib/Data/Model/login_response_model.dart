// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class LoginSuccessModel {
  int? status;
  String? message;
  LoginData? data;
  String? token;

  LoginSuccessModel({this.status, this.message, this.data, this.token});

  LoginSuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class LoginData {
  String? sId;
  String? fullName;
  String? email;
  String? countryCode;
  String? phoneNo;
  String? file;
  String? address;
  String? socialMedia;
  String? role;
  String? token;
  String? fcmToken;
  String? oTP;
  bool? emailVerified;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LoginData(
      {this.sId,
      this.fullName,
      this.email,
      this.countryCode,
      this.phoneNo,
      this.file,
      this.address,
      this.socialMedia,
      this.role,
      this.token,
      this.fcmToken,
      this.oTP,
      this.emailVerified,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LoginData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    countryCode = json['country_code'];
    phoneNo = json['phone_no'];
    file = json['file'];
    address = json['address'];
    socialMedia = json['social_media'];
    role = json['role'];
    token = json['token'];
    fcmToken = json['fcmToken'];
    oTP = json['OTP'];
    emailVerified = json['email_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_no'] = this.phoneNo;
    data['file'] = this.file;
    data['address'] = this.address;
    data['social_media'] = this.socialMedia;
    data['role'] = this.role;
    data['token'] = this.token;
    data['fcmToken'] = this.fcmToken;
    data['OTP'] = this.oTP;
    data['email_verified'] = this.emailVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
