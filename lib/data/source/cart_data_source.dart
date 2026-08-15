import 'package:dio/dio.dart';
import 'package:vstore/common/http_client.dart';
import 'package:vstore/data/cart_item.dart';
import 'package:vstore/data/cart_response.dart';
import 'package:vstore/data/repo/cart_repository.dart'; // <-- new import, adjust path

final cartReposiorty = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartDataSource {
  Future<CartResponse> addToCart(int productId);
  Future<CartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartItemEntity>> getcart();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);
  @override
  Future<CartResponse> addToCart(int productId) async {
    final response = await httpClient.post(
      'cart',
      data: {"product_id": productId, "count": 1},
      options: Options(
        headers: {
          'Prefer': 'return=representation',
          'Content-Type': 'application/json',
        },
      ),
    );

    final data = (response.data as List).first as Map<String, dynamic>;
    return CartResponse.fromJson(data);
  }

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemEntity>> getcart() {
    // TODO: implement getcart
    throw UnimplementedError();
  }
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);

  @override
  Future<CartResponse> addToCart(int productId) =>
      dataSource.addToCart(productId);

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) =>
      dataSource.changeCount(cartItemId, count);

  @override
  Future<int> count() => dataSource.count();

  @override
  Future<void> delete(int cartItemId) => dataSource.delete(cartItemId);

  @override
  Future<List<CartItemEntity>> getcart() => dataSource.getcart();
}
