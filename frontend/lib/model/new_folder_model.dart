class NewFolderModel {
  String? name;
  String? label;

  NewFolderModel({this.name, this.label});

  NewFolderModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['label'] = label;
    return data;
  }
}
