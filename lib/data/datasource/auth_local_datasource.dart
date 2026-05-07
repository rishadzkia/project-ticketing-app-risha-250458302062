// Khusus untuk handle sesuatu yang disimpan di penyimpanan lokal hp
// Kayak token, data user, dll.
// Disini penyimpanan lokal pakai shared preferences,
// tapi bisa juga pake yang lain seperti Hive, Sqflite, dll.

// Shared preferences => Penyimpanan lokal di hp atau penimpanan data kecil (Token, sesi login)
// Sifatnya presisten (Data tetap ada walaupun aplikasi ditutup)

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing_app/data/model/response/auth_response_model.dart';

class AuthLocalDatasource {
  // Ini untuk menyimpan data login
  Future<void> saveAuthData(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', data.toJson());
  }

  // Remove data yang login
  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
  }

  // Ambil data yang login
  Future<AuthResponseModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    if (data != null) {
      return AuthResponseModel.fromJson(data);
    } else {
      throw Exception('Data auth tidak ditemukan');
    }
  }

  // Cek apakah user udah login atau belum
  Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('auth_data');
  }
}
