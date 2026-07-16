import 'package:vstore/data/common/http_response_validator.dart';
import 'package:vstore/data/product.dart';
import 'package:dio/dio.dart';

abstract class IproductDataSource {
  Future<List<ProductEntity>> getProducts(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource
    with HttpResponseValidator
    implements IproductDataSource {
  final Dio httpClient;
  ProductRemoteDataSource(this.httpClient);

  @override
  Future<List<ProductEntity>> getProducts(int sort) async {
    final response = await httpClient.get('rpc/get_products?sort_type=$sort');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get(
      'products?select=*&title=ilike.*$searchTerm*',
    );
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }
}
