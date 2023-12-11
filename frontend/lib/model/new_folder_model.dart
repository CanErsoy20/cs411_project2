class NewFolderModel {
  String? name;
  String? label;
  UserFolder? user;
  String? type;

  NewFolderModel({this.name, this.label, this.user, this.type});

  NewFolderModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
    user = json['user'] != null ? UserFolder.fromJson(json['user']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['label'] = label;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class UserFolder {
  int? userId;

  UserFolder({this.userId});

  UserFolder.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }
}
