import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vstore/common/http_client.dart';
import 'package:vstore/data/auth_info.dart';
import 'package:vstore/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(authHttpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> AuthChangeNotifier = ValueNotifier(
    null,
  );
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _persistAuthTokens(authInfo);
    debugPrint("access Token IS ---->         ${authInfo.accessToken}");
  }

  @override
  Future<void> register(String username, String password) async {
    final AuthInfo authInfo = await dataSource.register(username, password);
    _persistAuthTokens(authInfo);
    debugPrint("Access Token is -------------->  ${authInfo.accessToken}");
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo = await dataSource.refreshToken("4ikkrmzvh5ve");
    _persistAuthTokens(authInfo);
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? "";
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? "";
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      AuthChangeNotifier.value = AuthInfo(accessToken, refreshToken);
    }
  }
}
