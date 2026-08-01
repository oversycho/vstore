import 'package:dio/dio.dart';
import 'package:vstore/data/auth_info.dart';
import 'package:vstore/data/common/http_response_validator.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> register(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);
  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpClient.post(
      "token?grant_type=password",
      data: {"email": username, "password": password},
    );
    validateResponse(response);
    return AuthInfo(
      response.data["access_token"],
      response.data["refresh_token"],
    );
  }

  @override
  Future<AuthInfo> refreshToken(String token) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<AuthInfo> register(String username, String password) async {
    final response = await httpClient.post(
      "signup",
      data: {"email": username, "password": password},
    );
    validateResponse(response);
    return login(username, password);
  }
}
