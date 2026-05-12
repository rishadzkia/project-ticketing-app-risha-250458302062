// Ini untuk nge-handling login, logout, registrasi
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:ticketing_app/core/constants/variable.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/data/model/request/login_request_model.dart';
import 'package:ticketing_app/data/model/response/auth_response_model.dart';

class AuthRemoteDatasource {
  /// LOGIN
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel dataLogin,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },

        // ✅ FIX 1: encode ke JSON string
        body: jsonEncode(dataLogin.toJson()),
      );

      // 🔍 Debug (penting banget)
      print("STATUS LOGIN: ${response.statusCode}");
      print("BODY LOGIN: ${response.body}");

      if (response.statusCode == 200) {
        try {
          // ✅ FIX 2: decode dulu
          final json = jsonDecode(response.body);

          final data = AuthResponseModel.fromJson(json);

          return Right(data);
        } catch (e) {
          // ❗ kalau JSON gak sesuai
          print("JSON PARSE ERROR: $e");
          return Left("Format response tidak valid");
        }
      } else {
        return Left(response.body);
      }
    } catch (e) {
      // ❗ kalau request gagal (network, dll)
      print("REQUEST ERROR: $e");
      return Left("Terjadi kesalahan: $e");
    }
  }

  /// LOGOUT
  Future<Either<String, String>> logout() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      print("STATUS LOGOUT: ${response.statusCode}");
      print("BODY LOGOUT: ${response.body}");

      if (response.statusCode == 200) {
        return const Right('Logout Berhasil');
      } else {
        return Left(response.body);
      }
    } catch (e) {
      return Left("Terjadi kesalahan: $e");
    }
  }
}
