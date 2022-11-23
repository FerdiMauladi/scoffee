class DetailCoffeeModel {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? description;
  String? story;
  String? createdAt;
  String? updatedAt;

  DetailCoffeeModel(
      {this.id,
        this.name,
        this.slug,
        this.image,
        this.description,
        this.story,
        this.createdAt,
        this.updatedAt});

  DetailCoffeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    description = json['description'];
    story = json['story'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['description'] = description;
    data['story'] = story;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}