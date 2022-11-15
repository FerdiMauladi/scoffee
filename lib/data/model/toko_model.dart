class TokoModel {
  Meta? meta;
  List<Data>? data;

  TokoModel({this.meta, this.data});

  TokoModel.fromJson(Map<String, dynamic> json) {
    meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (meta != null) {
      _data["meta"] = meta?.toJson();
    }
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? idUser;
  String? name;
  String? address;
  String? phone;
  String? image;
  String? status;
  String? userName;

  Data(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.idUser,
      this.name,
      this.address,
      this.phone,
      this.image,
      this.status,
      this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    idUser = json["id_user"];
    name = json["name"];
    address = json["address"];
    phone = json["phone"];
    image = json["image"];
    status = json["status"];
    userName = json["user_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["id_user"] = idUser;
    _data["name"] = name;
    _data["address"] = address;
    _data["phone"] = phone;
    _data["image"] = image;
    _data["status"] = status;
    _data["user_name"] = userName;
    return _data;
  }
}

class Meta {
  int? code;
  String? status;
  String? message;

  Meta({this.code, this.status, this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json["status"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["status"] = status;
    _data["message"] = message;
    return _data;
  }
}
