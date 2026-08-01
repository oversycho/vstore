import 'package:dio/dio.dart';

const _supabaseUrl = 'https://frxsmlmssbsfsieguvaz.supabase.co';
const _anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyeHNtbG1zc2JzZnNpZWd1dmF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA3ODY1NzYsImV4cCI6MjA5NjM2MjU3Nn0.emLEteYaw1WHZZN1XutW0KbY0wu0wMqUqrhhrUS-Eso';

// For database/table calls (products, comments, banners, etc.)
final httpClient = Dio(
  BaseOptions(
    baseUrl: '$_supabaseUrl/rest/v1/',
    headers: {'apikey': _anonKey, 'Content-Type': 'application/json'},
  ),
);

// For auth calls (login, signup, refresh, logout)
final authHttpClient = Dio(
  BaseOptions(
    baseUrl: '$_supabaseUrl/auth/v1/',
    headers: {'apikey': _anonKey, 'Content-Type': 'application/json'},
  ),
);
