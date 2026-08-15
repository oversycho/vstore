import 'package:dio/dio.dart';
import 'package:vstore/data/repo/auth_repository.dart';

const _supabaseUrl = 'https://frxsmlmssbsfsieguvaz.supabase.co';
const _anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyeHNtbG1zc2JzZnNpZWd1dmF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA3ODY1NzYsImV4cCI6MjA5NjM2MjU3Nn0.emLEteYaw1WHZZN1XutW0KbY0wu0wMqUqrhhrUS-Eso';

// For database/table calls (products, comments, banners, etc.)
final httpClient =
    Dio(
        BaseOptions(
          baseUrl: '$_supabaseUrl/rest/v1/',
          headers: {'apikey': _anonKey, 'Content-Type': 'application/json'},
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final authInfo = AuthRepository.AuthChangeNotifier.value;
            if (authInfo != null && authInfo.accessToken.isNotEmpty) {
              options.headers['authorization'] =
                  'Bearer ${authInfo.accessToken}';
            }
            handler.next(options);
          },
        ),
      );

// For auth calls (login, signup, refresh, logout)
final authHttpClient = Dio(
  BaseOptions(
    baseUrl: '$_supabaseUrl/auth/v1/',
    headers: {'apikey': _anonKey, 'Content-Type': 'application/json'},
  ),
);
