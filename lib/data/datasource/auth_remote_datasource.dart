// Ini untuk nge-handling login, logout, registrasi
import 'package:dartz/dartz.dart';
import 'package:ticketing_app/core/constants/variable.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/data/model/request/login_request_model.dart';
import 'package:ticketing_app/data/model/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel dataLogin,
  ) async {
    final response = await http.post(
      // url utama kan disimpan di variable
      Uri.parse('${Variable.baseUrl}/api/login'),
      headers: <String, String>{
        // Ini isi header di postman
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      }, 
      // Ini body yang ada di postman
      body: dataLogin.toJson(),
    );
    // Status kode: 200
    if (response.statusCode == 200) {
      // Ini buat nyimpen response email
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  // Untuk logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right('Logout Berhasil');
    } else {
      return Left(response.body);
    }
  }
}
