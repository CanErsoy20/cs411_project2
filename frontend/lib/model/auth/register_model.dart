class RegisterModel {
  int? id;
  String? email;
  String? password;

  RegisterModel({this.id, this.email, this.password});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
