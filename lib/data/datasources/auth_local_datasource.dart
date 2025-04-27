import 'package:ecommerce_seller_app/data/model/response/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveLoginData(LoginResponseModel c) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('login_data', c.toJson());
  }

  Future<void> removeLoginData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('login_data');
  }

  Future<LoginResponseModel> getLoginData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('login_data');
    return LoginResponseModel.fromJson(data!);
  }

  Future<bool> checkLoginData() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('login_data');
  }
}
