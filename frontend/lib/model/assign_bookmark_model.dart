class AssignBookmarkModel {
  String? name;
  String? label;
  String? type;
  String? url;

  AssignBookmarkModel({this.name, this.label, this.type, this.url});

  AssignBookmarkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['label'] = label;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
