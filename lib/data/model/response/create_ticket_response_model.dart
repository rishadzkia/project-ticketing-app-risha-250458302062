import 'dart:convert';

import 'package:ticketing_app/data/model/response/product_response_model.dart';

class CreateTicketResponsetModel {
  final String status;
  final Product data;

  CreateTicketResponsetModel({required this.status, required this.data});

  factory CreateTicketResponsetModel.fromJson(String str) =>
      CreateTicketResponsetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateTicketResponsetModel.fromMap(Map<String, dynamic> json) =>
      CreateTicketResponsetModel(
        status: json["Status"],
        data: Product.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"Status": status, "data": data.toMap()};
}
