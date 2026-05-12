part of 'login_bloc.dart';

@freezed
// Event: sesutu yang mau kita lakukan
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.started() = _Started;
  const factory LoginEvent.login({
    required String email,
    required String password,
  }) = _login;
}
