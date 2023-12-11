import 'package:cs411_project2/model/bookmark_item_model.dart';

class UserModel {
  int? userId;
  String? email;
  List<BookmarkItemModel>? items;

  UserModel({this.userId, this.email, this.items});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    if (json['items'] != null) {
      items = <BookmarkItemModel>[];
      json['items'].forEach((v) {
        items!.add(BookmarkItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
