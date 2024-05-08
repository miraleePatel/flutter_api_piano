class GetPianoTypeModel {
  int? status;
  String? message;
  List<PianoType>? data;

  GetPianoTypeModel({this.status, this.message, this.data});

  GetPianoTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PianoType>[];
      json['data'].forEach((v) {
        data!.add(PianoType.fromJson(v));
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

class PianoType {
  String? sId;
  String? type;

  PianoType({this.sId, this.type});

  PianoType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    return data;
  }
}
