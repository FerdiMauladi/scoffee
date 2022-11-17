class EventModel {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;

  EventModel(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to});

  EventModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    return data;
  }
}

class Data {
  int? id;
  String? author;
  String? image;
  String? title;
  String? slug;
  String? body;
  String? date;
  int? statusPublish;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.author,
        this.image,
        this.title,
        this.slug,
        this.body,
        this.date,
        this.statusPublish,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
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
    data['author'] = author;
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