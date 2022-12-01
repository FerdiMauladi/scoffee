class DetailEducationModel {
  int? id;
  String? author;
  String? image;
  String? title;
  String? slug;
  String? body;
  String? createdAt;
  String? updatedAt;

  DetailEducationModel(
      {this.id,
        this.author,
        this.image,
        this.title,
        this.slug,
        this.body,
        this.createdAt,
        this.updatedAt});

  DetailEducationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    image = json['image'];
    title = json['title'];
    slug = json['slug'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['image'] = image;
    data['title'] = title;
    data['slug'] = slug;
    data['body'] = body;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}