import 'package:dio/dio.dart';
import 'package:vstore/data/product.dart';
import 'package:vstore/data/source/product_data_source.dart';

final httpClient = Dio(
  BaseOptions(
    baseUrl: 'https://frxsmlmssbsfsieguvaz.supabase.co/rest/v1/',
    headers: {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyeHNtbG1zc2JzZnNpZWd1dmF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA3ODY1NzYsImV4cCI6MjA5NjM2MjU3Nn0.emLEteYaw1WHZZN1XutW0KbY0wu0wMqUqrhhrUS-Eso',
    },
  ),
);

final productRepository = ProductRepository(
  ProductRemoteDataSource(httpClient),
);

abstract class IProductRepository {
  Future<List<ProductEntity>> getProducts(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IproductDataSource dataSource;
  ProductRepository(this.dataSource);

  @override
  Future<List<ProductEntity>> getProducts(int sort) =>
      dataSource.getProducts(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) {
    return dataSource.search(searchTerm);
  }
}
