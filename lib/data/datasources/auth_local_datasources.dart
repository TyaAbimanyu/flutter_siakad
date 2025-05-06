import 'package:flutter_siakad_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasources {
  Future<bool> saveUserToken(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    final token = await pref.setString('auth', data.toJson());

    return token;
  }

  Future<bool> removeUserToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = await pref.remove('auth');

    return token;
  }

  Future<String> getUserToken() async {
    final pref = await SharedPreferences.getInstance();
    final jsonString = pref.getString('auth') ?? '';

    if (jsonString.isEmpty || jsonString == 'null') {
      return '';
    }

    final authResponseModel = AuthResponseModel.fromJson(jsonString);
    return authResponseModel.token;
  }

  Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('auth') ?? '';

    if (token.isEmpty || token == 'null') {
      return false;
    }

    return true;
  }
}
