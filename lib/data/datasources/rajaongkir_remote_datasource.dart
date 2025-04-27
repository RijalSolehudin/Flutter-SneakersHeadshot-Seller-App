import 'package:dartz/dartz.dart';
import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:http/http.dart' as http;

import '../model/response/city_response_model.dart';
import '../model/response/province_response_model.dart';
import '../model/response/subdistrict_response_model.dart';

class RajaongkirRemoteDatasource {
  //    GET LIST PROVINCE
  Future<Either<String, ProvinceResponseModel>> getProvince() async {
    final url = Uri.parse(
        "${Variables.RajaOngkirBaseURL}/province?key=${Variables.RajaOngkirApiKey}");

    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return Right(ProvinceResponseModel.fromJson(response.body));
    } else {
      return const Left("Loading Failed");
    }
  }

  //    GET LIST CITY
  Future<Either<String, CityResponseModel>> getCity(int provinceId) async {
    final url = Uri.parse(
        "${Variables.RajaOngkirBaseURL}/city?key=${Variables.RajaOngkirApiKey}&province=${provinceId}");

    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return Right(CityResponseModel.fromJson(response.body));
    } else {
      return const Left("Loading Failed");
    }
  }

  //  GET LIST SUBDISTRICT
  Future<Either<String, SubdistrictResponseModel>> getSubdistrict(
      int cityId) async {
    final url = Uri.parse(
        "${Variables.RajaOngkirBaseURL}/subdistrict?key=${Variables.RajaOngkirApiKey}&city=${cityId}");

    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return Right(SubdistrictResponseModel.fromJson(response.body));
    } else {
      return const Left("Loading Failed");
    }
  }
}
