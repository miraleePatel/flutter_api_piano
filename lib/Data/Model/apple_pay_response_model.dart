// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class ApplePayResponseModel {
  String? transactionIdentifier;
  TokenModel? token;
  PaymentMethod? paymentMethod;

  ApplePayResponseModel({this.transactionIdentifier, this.token, this.paymentMethod});

  ApplePayResponseModel.fromJson(Map<String, dynamic> json) {
    transactionIdentifier = json['transactionIdentifier'];
    // token = json['token'];
    token = json['token'] != null ? new TokenModel.fromJson(json['token']) : null;
    paymentMethod = json['paymentMethod'] != null ? new PaymentMethod.fromJson(json['paymentMethod']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionIdentifier'] = this.transactionIdentifier;
    // data['token'] = this.token;
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    if (this.paymentMethod != null) {
      data['paymentMethod'] = this.paymentMethod!.toJson();
    }
    return data;
  }
}

class TokenModel {
  String? data;
  String? signature;
  Header? header;
  String? version;

  TokenModel({this.data, this.signature, this.header, this.version});

  TokenModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    signature = json['signature'];
    header = json['header'] != null ? new Header.fromJson(json['header']) : null;
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['signature'] = this.signature;
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    data['version'] = this.version;
    return data;
  }
}

class Header {
  String? publicKeyHash;
  String? ephemeralPublicKey;
  String? transactionId;

  Header({this.publicKeyHash, this.ephemeralPublicKey, this.transactionId});

  Header.fromJson(Map<String, dynamic> json) {
    publicKeyHash = json['publicKeyHash'];
    ephemeralPublicKey = json['ephemeralPublicKey'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicKeyHash'] = this.publicKeyHash;
    data['ephemeralPublicKey'] = this.ephemeralPublicKey;
    data['transactionId'] = this.transactionId;
    return data;
  }
}

class PaymentMethod {
  String? displayName;
  String? network;
  int? type;

  PaymentMethod({this.displayName, this.network, this.type});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    network = json['network'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['network'] = this.network;
    data['type'] = this.type;
    return data;
  }
}
