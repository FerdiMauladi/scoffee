class DetailDiscussModel {
  Forums? forums;
  int? totalLikes;
  Comments? comments;

  DetailDiscussModel({this.forums, this.totalLikes, this.comments});

  DetailDiscussModel.fromJson(Map<String, dynamic> json) {
    forums =
    json['forums'] != null ? Forums.fromJson(json['forums']) : null;
    totalLikes = json['total_likes'];
    comments = json['comments'] != null
        ? Comments.fromJson(json['comments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forums != null) {
      data['forums'] = forums!.toJson();
    }
    data['total_likes'] = totalLikes;
    if (comments != null) {
      data['comments'] = comments!.toJson();
    }
    return data;
  }
}

class Forums {
  int? id;
  int? userId;
  String? userImage;
  String? user;
  String? category;
  String? context;
  String? description;
  String? image;

  Forums(
      {this.id,
        this.userId,
        this.userImage,
        this.user,
        this.category,
        this.context,
        this.description,
        this.image});

  Forums.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userImage = json['user_image'];
    user = json['user'];
    category = json['category'];
    context = json['context'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_image'] = userImage;
    data['user'] = user;
    data['category'] = category;
    data['context'] = context;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}

class Comments {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Comments(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Comments.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  String? userImage;
  String? user;
  String? content;
  String? createdAt;

  Data({this.id, this.userImage, this.user, this.content, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userImage = json['user_image'];
    user = json['user'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_image'] = userImage;
    data['user'] = user;
    data['content'] = content;
    data['created_at'] = createdAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}