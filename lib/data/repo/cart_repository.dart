import 'package:vstore/data/cart_item.dart';
import 'package:vstore/data/add_to_cart_response.dart';
import 'package:vstore/data/cart_response.dart';
import 'package:vstore/data/source/cart_data_source.dart';

abstract class ICartRepository {
  Future<AddToCartResponse> addToCart(int productId);
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getcart();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<AddToCartResponse> addToCart(int productId) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) {
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
  Future<CartResponse> getcart() {
    return dataSource.getcart();
  }
}
