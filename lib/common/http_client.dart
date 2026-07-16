import 'package:dio/dio.dart';

final httpClient = Dio(
  BaseOptions(
    baseUrl: 'https://frxsmlmssbsfsieguvaz.supabase.co/rest/v1/',
    headers: {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyeHNtbG1zc2JzZnNpZWd1dmF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA3ODY1NzYsImV4cCI6MjA5NjM2MjU3Nn0.emLEteYaw1WHZZN1XutW0KbY0wu0wMqUqrhhrUS-Eso',
    },
  ),
);
