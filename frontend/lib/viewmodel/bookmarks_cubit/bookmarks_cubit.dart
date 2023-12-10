import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../model/bookmark_model.dart';
import '../../model/filter_model.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit() : super(BookmarksInitial());
  List<Bookmark> myBookmarks = [
    Bookmark(
        name: "Facebook", url: "https://facebook.com", label: "Social Media"),
    Bookmark(name: "Research", url: "https://google.com", label: "Research"),
    Bookmark(
        name: "Youtube", url: "https://youtube.com", label: "Social Media"),
    Bookmark(
        name: "Twitter", url: "https://twitter.com", label: "Social Media"),
  ];
  List<PopupMenuItem> filters = [];
  List<Filter> filterList = [
    Filter("Social Media", false),
    Filter("Research", false),
    Filter("Shopping", false),
    Filter("News", false),
  ];
  void setFilters() {
    filters = filterList
        .map(
          (filter) => PopupMenuItem(
              value: filter.title,
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(filter.title!),
                  value: filter.value,
                  onChanged: (value) {
                    changeFilter(filter.title!, value ?? false);
                  })),
        )
        .toList();
  }

  void changeFilter(String title, bool value) {
    emit(BookmarksFilter());
    filterList.firstWhere((element) => element.title == title).value = value;
    setFilters();
    emit(BookmarksDisplay());
  }
}
