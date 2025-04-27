import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

class AgoraRemoteDatasource {
  //Get Token
  Future<Either<String, String>> getAgoraToken(
      String channelName, String uid) async {
    final url = Uri.parse("${Variables.BaseUrlApp}/api/agora/token");
    var authData = await AuthLocalDatasource().getLoginData();
    final header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer ${authData.data!.token}"
    };

    final response = await http.post(url,
        headers: header,
        body: jsonEncode(
            {"channelName": channelName, "uid": uid, "role": "RolePublisher"}));

    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body)["token"]);
    } else {
      return const Left("Gagal mendapatkan Token");
    }
  }
}
