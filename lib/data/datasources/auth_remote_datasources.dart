import 'package:dartz/dartz.dart';
import 'package:flutter_siakad_app/common/constants/variables.dart';
import 'package:flutter_siakad_app/data/models/request/auth_request_model.dart';
import 'package:flutter_siakad_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasources {
  Future<Either<String, AuthResponseModel>> login(
      AuthRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(Uri.parse('${Variables.apiUrl}/api/login'),
        headers: headers, body: requestModel.toJson());

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else if (response.statusCode == 401) {
      return const Left('Unauthorized');
    } else if (response.statusCode == 422) {
      return const Left('Invalid email or password');
    } else {
      return const Left('Something went wrong');
    }
  }
}
