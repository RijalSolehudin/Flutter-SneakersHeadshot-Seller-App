import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_seller_app/data/model/response/history_order_response_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  // Get History Order
  Future<Either<String, GetOrderHistoriesResponseModel>>
      getHistoryOrder() async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/seller/order/history");
    var authData = await AuthLocalDatasource().getLoginData();
    final header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer ${authData.data!.token}"
    };

    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      return Right(GetOrderHistoriesResponseModel.fromJson(response.body));
    } else {
      return const Left("Gagal mendapat Data");
    }
  }

  // Update Resi number

  Future<Either<String, String>> updateResi(int orderId, String resi) async {
    final url = Uri.parse(
        "${Variables.BaseUrlApp}/api/seller/order/$orderId/update-resi");
    var authData = await AuthLocalDatasource().getLoginData();
    final header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer ${authData.data!.token}"
    };
    final response = await http.put(url,
        headers: header, body: jsonEncode({"shipping_number": resi}));

    if (response.statusCode == 200) {
      return const Right("Resi berhasil di Update");
    } else {
      return const Left("Gagal mengupdate Resi");
    }
  }
}
