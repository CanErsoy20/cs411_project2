class Bookmark {
  int? bookmarkId;
  int? userId;
  String? name;
  String? url;
  String? label;

  Bookmark({this.bookmarkId, this.userId, this.name, this.url, this.label});

  Bookmark.fromJson(Map<String, dynamic> json) {
    bookmarkId = json['bookmarkId'];
    userId = json['userId'];
    name = json['name'];
    url = json['url'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookmarkId'] = bookmarkId;
    data['userId'] = userId;
    data['name'] = name;
    data['url'] = url;
    data['label'] = label;
    return data;
  }
}
