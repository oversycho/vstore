import 'package:flutter/foundation.dart';
import 'package:vstore/common/http_client.dart';
import 'package:vstore/data/auth_info.dart';
import 'package:vstore/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(authHttpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  /*   Future<void> register(String profileName, String username, String password);
  Future<void> refreshToken(String username, String password); */
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    debugPrint("access Token IS ---->         " + authInfo.accessToken);
  }
}
