import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../model/auth/login_model.dart';
import '../../model/auth/register_model.dart';
import '../../model/user/user_model.dart';
import '../../services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.service) : super(AuthInitial());
  final AuthService service;
  final LoginModel loginModel = LoginModel();
  final RegisterModel registerModel = RegisterModel();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  Future<void> login() async {
    emit(AuthLoading());
    loginModel.email = loginEmailController.text;
    loginModel.password = loginPasswordController.text;
    UserModel? response = await service.login(loginModel);
    if (response != null) {
      emit(AuthSuccess("Successfully logged in", "Lets go browsing!"));
    } else {
      emit(AuthError("Login Failed", "Your email or password is incorrect"));
    }
  }

  Future<void> register() async {
    emit(AuthLoading());
    registerModel.email = registerEmailController.text;
    registerModel.password = registerPasswordController.text;
    UserModel? response = await service.register(registerModel);
    if (response != null) {
      emit(AuthSuccess("Successfully registered", "Lets go browsing!"));
    } else {
      emit(AuthError(
          "Registration Failed", "Something went wrong, please try again"));
    }
  }
}
