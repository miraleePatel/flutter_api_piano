


class FilterPianoModel {
  int? status;
  String? message;
  List<FilterPiano>? data;

  FilterPianoModel({this.status, this.message, this.data});

  FilterPianoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FilterPiano>[];
      json['data'].forEach((v) {
        data!.add(FilterPiano.fromJson(v));
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

class FilterPiano {
  String? sId;
  String? heading;
  String? title;
  String? desc;
  String? brand;
  String? model;
  String? color;
  String? dimension;
  String? file;
  List<String>? categories;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FilterPiano(
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

  FilterPiano.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    heading = json['heading'];
    title = json['title'];
    desc = json['desc'];
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    dimension = json['dimension'];
    file = json['file'];
    categories = json['categories'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['heading'] = heading;
    data['title'] = title;
    data['desc'] = desc;
    data['brand'] = brand;
    data['model'] = model;
    data['color'] = color;
    data['dimension'] = dimension;
    data['file'] = file;
    data['categories'] = categories;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
