import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_seller_app/data/model/response/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:ecommerce_seller_app/data/model/request/register_request_model.dart';
import 'package:ecommerce_seller_app/data/model/response/register_response_model.dart';

class AuthRemoteDatasource {
//  Register
  Future<Either<String, RegisterResponseModel>> register(
      RegisterRequestModel data) async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/seller/register");

    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(data.toMap());
    request.files
        .add(await http.MultipartFile.fromPath('photo', data.image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromJson(
          await response.stream.bytesToString()));
    } else {
      return Left(response.reasonPhrase.toString());
    }
  }

  //Login
  Future<Either<String, LoginResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/login");
    final response = await http.post(url,
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return const Left('failed to Login');
    }
  }

  // LOGOUT
  Future<Either<String, String>> logout() async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/logout");
    var authdata = await AuthLocalDatasource().getLoginData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'bearer ${authdata.data!.token}'
    };
    final response = await http.post(url, headers: header);
    if (response.statusCode == 200) {
      await AuthLocalDatasource().removeLoginData();
      return const Right("Akun Berhasil Logotu");
    } else {
      return const Left("Logout Gagal");
    }
  }

  // Set Livestreaming Status

  Future<Either<String, String>> setLivestreaming(bool isActive) async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/seller/livestreaming");
    var authData = await AuthLocalDatasource().getLoginData();
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer ${authData.data!.token}"
    };

    final response = await http.post(url,
        headers: header, body: jsonEncode({"is_active": isActive}));
    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body));
    } else {
      return const Left("Tidak dapat melakukan livestreaming");
    }
  }

  //Update Fcm token
  Future<Either<String, String>> updateFcmToken(String fcmToken) async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/update-fcm-token");
    var authData = await AuthLocalDatasource().getLoginData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'bearer ${authData.data!.token}'
    };

    final response = await http.put(url,
        headers: header, body: jsonEncode({'fcm_token': fcmToken}));

    if (response.statusCode == 200) {
      return const Right("Token berhasil diupdate");
    } else {
      return const Left("Gagal mengupdate Token!");
    }
  }
}
