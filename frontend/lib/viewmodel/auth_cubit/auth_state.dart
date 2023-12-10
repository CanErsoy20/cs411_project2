part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthDisplay extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess(this.title, this.description);
  final String title;
  final String description;
}

final class AuthError extends AuthState {
  AuthError(this.title, this.description);
  final String title;
  final String description;
}
