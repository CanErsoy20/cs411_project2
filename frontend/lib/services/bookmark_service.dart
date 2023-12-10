import 'dart:convert';

import 'package:cs411_project2/model/new_bookmark_model.dart';
import 'package:cs411_project2/model/new_folder_model.dart';
import 'package:cs411_project2/model/response_model.dart';
import 'package:cs411_project2/services/api.dart';
import 'package:http/http.dart';

import '../constants/api_constants.dart';

class BookmarkService {
  Future<dynamic> addBookmark(NewBookmarkModel newBookmarkModel) async {}

  Future<dynamic> addFolder(NewFolderModel newFolderModel) async {}

  Future<dynamic> assignBookmark(NewBookmarkModel newBookmarkModel) async {}

  Future<dynamic> deleteFolder(int id) async {
    try {
      Response? response;
      response = await Api.instance.deleteRequest(
          ApiConstants.baseUrl, "${ApiConstants.deleteFolder}$id");
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

  Future<dynamic> deleteBookmark(int id) async {
    try {
      Response? response;
      response = await Api.instance.deleteRequest(
          ApiConstants.baseUrl, "${ApiConstants.deleteBookmark}$id");
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
}
