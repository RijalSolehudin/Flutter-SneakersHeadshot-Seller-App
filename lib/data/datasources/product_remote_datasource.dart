import 'package:dartz/dartz.dart';
import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_seller_app/data/model/request/add_product_request_model.dart';
import 'package:ecommerce_seller_app/data/model/request/edit_product_request_model.dart';
import 'package:ecommerce_seller_app/data/model/response/add_product_response_model.dart';
import 'package:http/http.dart' as http;

import '../model/response/products_response_model.dart';

class ProductRemoteDatasource {
  // GET
  Future<Either<String, ProductsResponseModel>> getProducts() async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/seller/products");
    var authData = await AuthLocalDatasource().getLoginData();
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer ${authData.data!.token}"
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left("Gagal Memuat Data");
    }
  }

  // Create New Product
  Future<Either<String, AddProductsResponseModel>> addProduct(
      AddProductRequestModel data) async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/seller/products");
    var authData = await AuthLocalDatasource().getLoginData();
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer ${authData.data!.token}"
    };
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(data.toMap());
    request.files
        .add(await http.MultipartFile.fromPath('image', data.image.path));
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 201) {
      return Right(AddProductsResponseModel.fromJson(
          await response.stream.bytesToString()));
    } else {
      return const Left('Gagal menambah data');
    }
  }

  // Delete Product
  Future<Either<String, String>> deleteProduct(int id) async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/seller/products/$id");
    var auth = await AuthLocalDatasource().getLoginData();
    final headers = {
      "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "bearer ${auth.data!.token}"
    };

    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return const Right("Product Berhasil dihapus");
    } else {
      return const Left("Gagal menghapus produk");
    }
  }

  //Update Product
  Future<Either<String, AddProductsResponseModel>> editProduct(
      EditProductRequestModel data) async {
    final url =
        Uri.parse("${Variables.BaseUrlApp}/api/seller/products/${data.id}");
    var authData = await AuthLocalDatasource().getLoginData();
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer ${authData.data!.token}"
    };
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(data.toMap());
    if (data.image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', data.image!.path));
    }

    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      return Right(AddProductsResponseModel.fromJson(
          await response.stream.bytesToString()));
    } else {
      return const Left('Gagal Mengubah data');
    }
  }
}
