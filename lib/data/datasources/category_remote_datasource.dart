import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_seller_app/data/model/response/categories_response_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<Either<String, CategoryResponseModel>> getCategories() async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/seller/categories");
    var authData = await AuthLocalDatasource().getLoginData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'bearer ${authData.data!.token}'
    };
    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      return Right(CategoryResponseModel.fromJson(response.body));
    } else {
      return const Left("gagal memuat Kategori");
    }
  }

  Future<Either<String, String>> addCategory(String name) async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/seller/category");
    var authData = await AuthLocalDatasource().getLoginData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'bearer ${authData.data!.token}'
    };

    final response = await http.post(url,
        headers: header, body: jsonEncode({'name': name, 'description': name}));

    if (response.statusCode == 201) {
      return const Right('Berhasil menambahkan kategori');
    } else {
      return const Left('Gagal Menambahkan Kategori');
    }
  }
}
