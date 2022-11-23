class DetailEventModel {
  int? id;
  int? userId;
  String? image;
  String? title;
  String? slug;
  String? body;
  String? date;
  String? statusPublish;
  String? createdAt;
  String? updatedAt;

  DetailEventModel(
      {this.id,
        this.userId,
        this.image,
        this.title,
        this.slug,
        this.body,
        this.date,
        this.statusPublish,
        this.createdAt,
        this.updatedAt});

  DetailEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    title = json['title'];
    slug = json['slug'];
    body = json['body'];
    date = json['date'];
    statusPublish = json['status_publish'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['title'] = title;
    data['slug'] = slug;
    data['body'] = body;
    data['date'] = date;
    data['status_publish'] = statusPublish;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}