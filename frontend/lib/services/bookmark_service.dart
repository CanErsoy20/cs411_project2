import 'dart:convert';

import 'package:cs411_project2/model/assign_bookmark_model.dart';
import 'package:cs411_project2/model/assign_folder_model.dart';
import 'package:cs411_project2/model/bookmark_item_model.dart';
import 'package:cs411_project2/model/new_bookmark_model.dart';
import 'package:cs411_project2/model/new_folder_model.dart';
import 'package:cs411_project2/model/response_model.dart';
import 'package:cs411_project2/model/user/user_info.dart';
import 'package:cs411_project2/services/api.dart';
import 'package:http/http.dart';

import '../constants/api_constants.dart';

class BookmarkService {
  Future<List<String>?> getMyLabels() async {
    try {
      Response? response;
      response = await Api.instance.getRequest(ApiConstants.baseUrl,
          "${ApiConstants.getUserLabels}${UserInfo.loggedUser!.userId!}");
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        List<String> labels = [];
        responseModel.data.forEach((element) {
          labels.add(element);
        });
        return labels;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<BookmarkItemModel>?> getMyBookmarks() async {
    try {
      Response? response;
      response = await Api.instance.getRequest(ApiConstants.baseUrl,
          "${ApiConstants.getUserItems}${UserInfo.loggedUser!.userId!}");
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        List<BookmarkItemModel> bookmarkItemModelList = [];
        responseModel.data.forEach((element) {
          bookmarkItemModelList.add(BookmarkItemModel.fromJson(element));
        });
        return bookmarkItemModelList;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<NewBookmarkModel?> addBookmark(
      NewBookmarkModel newBookmarkModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstants.baseUrl,
          ApiConstants.addBookmark, jsonEncode(newBookmarkModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return NewBookmarkModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<NewFolderModel?> addFolder(NewFolderModel newFolderModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstants.baseUrl,
          ApiConstants.addFolder, jsonEncode(newFolderModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return NewFolderModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> assignFolder(
      AssignFolderModel newFolderModel, int folderId) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(
          ApiConstants.baseUrl,
          "${ApiConstants.assignFolder}$folderId",
          jsonEncode(newFolderModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return responseModel.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> assignBookmark(
      AssignBookmarkModel newBookmarkModel, int folderId) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(
          ApiConstants.baseUrl,
          "${ApiConstants.assignBookmark}$folderId",
          jsonEncode(newBookmarkModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return responseModel.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> deleteFolder(int id) async {
    try {
      Response? response;
      response = await Api.instance.deleteRequest(
          ApiConstants.baseUrl, "${ApiConstants.deleteFolder}$id");
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> deleteBookmark(int id) async {
    try {
      Response? response;
      response = await Api.instance.deleteRequest(
          ApiConstants.baseUrl, "${ApiConstants.deleteBookmark}$id");
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
