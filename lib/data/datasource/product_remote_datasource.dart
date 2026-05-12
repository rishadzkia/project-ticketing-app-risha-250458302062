import 'package:dartz/dartz.dart';
import 'package:ticketing_app/core/constants/variable.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/data/model/request/create_ticket_request_model.dart';
import 'package:ticketing_app/data/model/response/create_ticket_response_model.dart';
import 'package:ticketing_app/data/model/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  // Buat ambil data produk dari API
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variable.baseUrl}/api/api-product'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
    );
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  // Ini untuk tambah data produk
  // Kalo create harus tambahin request di parameter
  Future<Either<String, CreateTicketResponsetModel>> createTicket(
    CreateTicketRequestModel model,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/api-product'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
      body: model.toJson(),
    );
    if (response.statusCode == 200) {
      return Right(CreateTicketResponsetModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}

// buat update data produk
Future<Either<String, CreateTicketResponsetModel>> updateTicket(
  CreateTicketRequestModel requestModel,
  int id,
) async {
  final authData = await AuthLocalDatasource().getAuthData();
  // Karena patch itu bisa buat update data sebagian aja atau yang kita mau
  // Tapi kalau pake put itu harus update
  final response = await http.patch(
    Uri.parse('${Variable.baseUrl}/api/api-product/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData.token}',
    },
    body: requestModel.toJson(),
  );
  if (response.statusCode == 200) {
    return Right(CreateTicketResponsetModel.fromJson(response.body));
  } else {
    return Left(response.body);
  }

  // Delete tiket

  Future<Either<String, String>> deleteTicket(int id) async{
    final authData = await AuthLocalDatasourch().getAuthData();
    final response = await http.delete(    //=> patch: update data sebagian
                                          //=> put: update semua data. kalau gda yg diupdate nnti jdi null
      Uri.parse('${(Variable.baseUrl)}/api/api-products/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}'
      }
    );
    if(response.statusCode == 200){
      return right('Delete berhasil');
    } else{
      return left(response.body);
    }
  }
}

// Saat ngirim data baru atau memperbarui data: post, pastch, put brrti butuh body
// Kalau buat get atau delete sbnrnya cukup endpoint dan header
