import 'package:cs411_project2/model/logo_response_model.dart';

class BookmarkItemModel {
  int? id;
  String? name;
  String? label;
  String? type;
  String? url;
  LogoResponse? logo;
  List<BookmarkItemModel>? items;

  BookmarkItemModel(
      {this.id, this.name, this.label, this.type, this.url, this.items});

  BookmarkItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
    type = json['type'];
    url = json['url'];
    if (json['items'] != null) {
      items = <BookmarkItemModel>[];
      json['items'].forEach((v) {
        items!.add(BookmarkItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['label'] = label;
    data['type'] = type;
    data['url'] = url;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<BookmarkItemModel> filterByLabel(List<String> selectedFilters) {
    List<BookmarkItemModel> result = [];

    if (selectedFilters.contains(label)) {
      result.add(this);
    }

    if (items != null) {
      for (var item in items!) {
        result.addAll(item.filterByLabel(selectedFilters));
      }
    }

    return result;
  }

  List<BookmarkItemModel> searchByName(String query) {
    List<BookmarkItemModel> result = [];

    if ((url?.toLowerCase().contains(query.toLowerCase()) ??
        false ||
            name!.toLowerCase().contains(query.toLowerCase()) ||
            label!.toLowerCase().contains(query.toLowerCase()))) {
      result.add(this);
    }

    if (items != null) {
      for (var item in items!) {
        result.addAll(item.searchByName(query));
      }
    }

    return result;
  }
}
