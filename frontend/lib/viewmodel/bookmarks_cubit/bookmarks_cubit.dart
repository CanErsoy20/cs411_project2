import 'package:bloc/bloc.dart';
import 'package:cs411_project2/model/assing_bookmark_model.dart';
import 'package:cs411_project2/model/bookmark_item_model.dart';
import 'package:cs411_project2/model/new_bookmark_model.dart';
import 'package:cs411_project2/model/new_folder_model.dart';
import 'package:cs411_project2/model/user/user_info.dart';
import 'package:cs411_project2/services/bookmark_service.dart';
import 'package:flutter/material.dart';
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

  List<BookmarkItemModel> myBookmarkItems = [];
  List<BookmarkItemModel> temp = [];

  List<String> selectedFilters = [];

  List<String> labels = [];

  Future<void> getMyLabels() async {
    emit(BookmarksLoading());
    final response = await service.getMyLabels();
    if (response == null) {
      emit(BookmarksError(title: "Error", description: "Could not get labels"));
    } else {
      labels.addAll(response);
      emit(BookmarksDisplay());
    }
  }

  // Bookmark Methods
  Future<void> getMyBookmarks() async {
    emit(BookmarksLoading());
    final response = await service.getMyBookmarks();
    getMyLabels();
    if (response == null) {
      emit(BookmarksError(
          title: "Error", description: "Could not get bookmarks"));
    } else {
      myBookmarkItems = response;
      temp = myBookmarkItems;
      emit(BookmarksDisplay());
    }
  }

  Future<void> addBookmark() async {
    emit(BookmarksLoading());
    NewBookmarkModel newModel = NewBookmarkModel(
        name: addBookmarkNameController.text,
        url: addBookmarkURLController.text,
        label: addBookmarkLabelController.text,
        type: "B",
        user: UserBookmark(userId: UserInfo.loggedUser!.userId));
    final response = await service.addBookmark(newModel);
    if (response == null) {
      emit(BookmarksError(
          title: "Error", description: "Could not add bookmark"));
    } else {
      emit(BookmarksSuccess(
          title: "Bookmark Added Successfully",
          description: "${newModel.name} added successfully"));
      getMyBookmarks();
    }
  }

  Future<void> addFolder() async {
    emit(BookmarksLoading());
    NewFolderModel newFolderModel = NewFolderModel(
        name: addFolderNameController.text,
        label: addFolderLabelController.text,
        type: "F",
        user: UserFolder(userId: UserInfo.loggedUser!.userId));
    final response = await service.addFolder(newFolderModel);
    if (response == null) {
      emit(BookmarksError(
          title: "Error", description: "Could not add bookmark"));
    } else {
      emit(BookmarksSuccess(
          title: "Folder Added Successfully",
          description: " ${newFolderModel.name} added successfully"));
      getMyBookmarks();
    }
  }

  Future<void> assignBookmark(int folderId) async {
    emit(BookmarksLoading());
    AssignBookmarkModel newModel = AssignBookmarkModel(
        name: assignBookmarkNameController.text,
        url: assignBookmarkURLController.text,
        label: assignBookmarkLabelController.text,
        type: "B");
    final response = await service.assignBookmark(newModel, folderId);
    if (response == null) {
      emit(BookmarksError(title: "Error", description: ""));
    } else {
      emit(BookmarksSuccess(title: "Success", description: ""));
      getMyBookmarks();
    }
  }

  Future<void> deleteFolder(int id) async {
    emit(BookmarksLoading());
    final response = await service.deleteFolder(id);
    if (response == null) {
      emit(BookmarksError(title: "Error", description: ""));
    } else {
      emit(BookmarksSuccess(title: "Success", description: ""));
      getMyBookmarks();
    }
  }

  Future<void> deleteBookmark(int id) async {
    emit(BookmarksLoading());
    final response = await service.deleteBookmark(id);
    if (response == null) {
      emit(BookmarksError(title: "Error", description: ""));
    } else {
      emit(BookmarksSuccess(title: "Success", description: ""));
      getMyBookmarks();
    }
  }

  // Clear textfields

  void clearForms() {
    addBookmarkNameController.clear();
    addBookmarkURLController.clear();
    addBookmarkLabelController.clear();
    addFolderNameController.clear();
    addFolderLabelController.clear();
    assignBookmarkNameController.clear();
    assignBookmarkURLController.clear();
    assignBookmarkLabelController.clear();
  }

  // Search and Filter methods
  void searchBookmark(String query) {
    filterByLabel();
    if (query.isNotEmpty) {
      temp = myBookmarkItems
          .where((element) =>
              element.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(BookmarksDisplay());
    } else {
      temp = myBookmarkItems;
      emit(BookmarksDisplay());
    }
  }

  void clearSearch() {
    searchBookmarkController.clear();
    temp = myBookmarkItems;
    emit(BookmarksDisplay());
  }

  void refresh() {
    emit(BookmarksChecking());
    emit(BookmarksDisplay());
  }

  void filterByLabel() {
    if (selectedFilters.isEmpty) {
      temp = myBookmarkItems;
    } else {
      temp = myBookmarkItems
          .where((element) => selectedFilters.contains(element.label))
          .toList();
    }
    emit(BookmarksDisplay());
  }
}
