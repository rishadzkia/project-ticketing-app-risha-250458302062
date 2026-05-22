import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http; 

import 'package:ticketing_app/core/constants/variable.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/data/model/request/create_ticket_request_model.dart';
import 'package:ticketing_app/data/model/response/create_ticket_response_model.dart';
import 'package:ticketing_app/data/model/response/product_response_model.dart';

class ProductRemoteDatasource {
  // GET PRODUCT
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

  // CREATE PRODUCT
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

  // UPDATE PRODUCT
  Future<Either<String, CreateTicketResponsetModel>> updateTicket(
    CreateTicketRequestModel requestModel,
    int id,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();

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
  }

  // DELETE PRODUCT
  Future<Either<String, String>> deleteTicket(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.delete(
      Uri.parse('${Variable.baseUrl}/api/api-product/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right('Delete berhasil');
    } else {
      // nganselin pesan yang udh ada di laravel
      return Left(response.body);
    }
  }
}

// Saat ngirim data baru atau memperbarui data:
// POST, PATCH, PUT => butuh body

// Kalau GET atau DELETE:
// cukup endpoint dan header
