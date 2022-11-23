class UserModel {
  int? id;
  String? name;
  String? email;
  String? roles;
  UserDetail? userDetail;

  UserModel({this.id, this.name, this.email, this.roles, this.userDetail});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roles = json['roles'];
    userDetail = json['user_detail'] != null
        ? UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['roles'] = roles;
    if (userDetail != null) {
      data['user_detail'] = userDetail!.toJson();
    }
    return data;
  }
}

class UserDetail {
  int? id;
  String? image;
  String? description;
  String? born;
  String? academic;
  String? work;
  String? userId;
  String? createdAt;
  String? updatedAt;

  UserDetail(
      {this.id,
        this.image,
        this.description,
        this.born,
        this.academic,
        this.work,
        this.userId,
        this.createdAt,
        this.updatedAt});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    description = json['description'];
    born = json['born'];
    academic = json['academic'];
    work = json['work'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['description'] = description;
    data['born'] = born;
    data['academic'] = academic;
    data['work'] = work;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}