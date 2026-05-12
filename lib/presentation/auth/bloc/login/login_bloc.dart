import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticketing_app/data/datasource/auth_remote_datasource.dart';
import 'package:ticketing_app/data/model/request/login_request_model.dart';
import 'package:ticketing_app/data/model/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;

  LoginBloc(this.authRemoteDatasource) : super(const _Initial()) {
    on<_login>((event, emit) async {
      emit(const _Loading());

      try {
        final dataRequest = LoginRequestModel(
          email: event.email,
          password: event.password,
        );

        final response = await authRemoteDatasource.login(dataRequest);

        response.fold(
          (error) {
            // ❗ biar keliatan di console
            print("LOGIN ERROR: $error");
            emit(_Error(error));
          },
          (data) {
            print("LOGIN SUCCESS");
            emit(_Success(data));
          },
        );
      } catch (e, stackTrace) {
        // ❗ ini yang bikin app kamu tadi crash → sekarang ditangkap
        print("BLOC CRASH: $e");
        print("STACKTRACE: $stackTrace");

        emit(_Error(e.toString()));
      }
    });
  }
}
