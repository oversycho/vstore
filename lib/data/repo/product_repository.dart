import 'package:vstore/common/http_client.dart';
import 'package:vstore/data/product.dart';
import 'package:vstore/data/source/product_data_source.dart';

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
