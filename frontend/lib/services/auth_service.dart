import 'dart:convert';
import 'package:http/http.dart';

import '../constants/api_constants.dart';
import '../model/auth/login_model.dart';
import '../model/auth/register_model.dart';
import '../model/response_model.dart';
import '../model/user/user_info.dart';
import '../model/user/user_model.dart';
import 'api.dart';

class AuthService {
  AuthService();
  Future<UserModel?> register(RegisterModel bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstants.baseUrl,
          ApiConstants.register, jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return UserModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> login(LoginModel bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstants.baseUrl,
          ApiConstants.login, jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = jsonDecode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        UserModel authResponseModel = UserModel.fromJson(responseModel.data);
        UserInfo.loggedUser = authResponseModel;
        return authResponseModel;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
