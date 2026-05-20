import 'package:ticketing_app/core/constants/variable.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/data/model/request/order_request_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDataSource {
  Future<bool> sendOrder(OrderRequestModel orderRequest) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/api-orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
      body: orderRequest.toJson(),
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print(
        'Error saat mengirim order: ${response.statusCode} = ${response.body}',
      );
      return false;
    }
  }
}
