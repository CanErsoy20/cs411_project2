import 'package:bloc/bloc.dart';
import 'package:cs411_project2/model/new_bookmark_model.dart';
import 'package:cs411_project2/model/new_folder_model.dart';
import 'package:cs411_project2/services/bookmark_service.dart';
import 'package:flutter/material.dart';

import '../../model/bookmark_model.dart';
import '../../model/filter_model.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit(this.service) : super(BookmarksInitial());
  BookmarkService service;
  TextEditingController searchBookmarkController = TextEditingController();

  TextEditingController addBookmarkNameController = TextEditingController();
  TextEditingController addBookmarkURLController = TextEditingController();
  TextEditingController addBookmarkLabelController = TextEditingController();

  TextEditingController addFolderNameController = TextEditingController();
  TextEditingController addFolderLabelController = TextEditingController();

  TextEditingController assignBookmarkNameController = TextEditingController();
  TextEditingController assignBookmarkURLController = TextEditingController();
  TextEditingController assignBookmarkLabelController = TextEditingController();

  List<Bookmark> myBookmarks = [
    Bookmark(
        name: "Facebook", url: "https://facebook.com", label: "Social Media"),
    Bookmark(name: "Research", url: "https://google.com", label: "Research"),
    Bookmark(
        name: "Youtube", url: "https://youtube.com", label: "Social Media"),
    Bookmark(
        name: "Twitter", url: "https://twitter.com", label: "Social Media"),
  ];
  List<Bookmark> temp = [
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

  // Bookmark Methods
  Future<void> addBookmark() async {
    emit(BookmarksLoading());
    NewBookmarkModel newModel = NewBookmarkModel(
        name: addBookmarkNameController.text,
        url: addBookmarkURLController.text,
        label: addBookmarkLabelController.text);
    final response = await service.addBookmark(newModel);
    if (response == null) {
      emit(BookmarksError(title: "Error", description: ""));
    } else {
      emit(BookmarksSuccess(title: "Success", description: ""));
    }
  }

  Future<void> addFolder() async {
    emit(BookmarksLoading());
    NewFolderModel newFolderModel = NewFolderModel(
        name: addFolderNameController.text,
        label: addFolderLabelController.text);
    final response = await service.addFolder(newFolderModel);
    if (response == null) {
      emit(BookmarksError(title: "Error", description: ""));
    } else {
      emit(BookmarksSuccess(title: "Success", description: ""));
    }
  }

  Future<void> assignBookmark() async {
    emit(BookmarksLoading());
    NewBookmarkModel newModel = NewBookmarkModel(
        name: assignBookmarkNameController.text,
        url: assignBookmarkURLController.text,
        label: assignBookmarkLabelController.text);
    final response = await service.assignBookmark(newModel);
    if (response == null) {
      emit(BookmarksError(title: "Error", description: ""));
    } else {
      emit(BookmarksSuccess(title: "Success", description: ""));
    }
  }

  Future<void> deleteFolder(int id) async {
    emit(BookmarksLoading());
    final response = await service.deleteFolder(id);
    if (response == null) {
      emit(BookmarksError(title: "Error", description: ""));
    } else {
      emit(BookmarksSuccess(title: "Success", description: ""));
    }
  }

  Future<void> deleteBookmark(int id) async {
    emit(BookmarksLoading());
    final response = await service.deleteBookmark(id);
    if (response == null) {
      emit(BookmarksError(title: "Error", description: ""));
    } else {
      emit(BookmarksSuccess(title: "Success", description: ""));
    }
  }

  // Search and Filter methods
  void searchBookmark(String query) {
    if (query.isNotEmpty) {
      temp = myBookmarks
          .where((element) =>
              element.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      emit(BookmarksDisplay());
    } else {
      temp = myBookmarks;
      emit(BookmarksDisplay());
    }
  }

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
    filterList.firstWhere((element) => element.title == title).value = value;
    setFilters();
    emit(BookmarksDisplay());
  }

  void clearSearch() {
    searchBookmarkController.clear();
    temp = myBookmarks;
    emit(BookmarksDisplay());
  }
}
