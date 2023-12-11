class NewBookmarkModel {
  String? name;
  String? label;
  UserBookmark? user;
  String? type;
  String? url;

  NewBookmarkModel({this.name, this.label, this.user, this.type, this.url});

  NewBookmarkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
    user = json['user'] != null ? UserBookmark.fromJson(json['user']) : null;
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['label'] = label;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}

class UserBookmark {
  int? userId;

  UserBookmark({this.userId});

  UserBookmark.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }
}
