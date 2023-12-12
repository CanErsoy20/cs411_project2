class AssignFolderModel {
  String? name;
  String? label;
  String? type;

  AssignFolderModel({this.name, this.label, this.type});

  AssignFolderModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['label'] = label;
    data['type'] = type;
    return data;
  }
}
