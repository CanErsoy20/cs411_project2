class NewBookmarkModel {
  String? name;
  String? url;
  String? label;

  NewBookmarkModel({this.name, this.url, this.label});

  NewBookmarkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['label'] = label;
    return data;
  }
}
