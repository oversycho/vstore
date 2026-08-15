import 'package:vstore/data/cart_item.dart';
import 'package:vstore/data/cart_response.dart';

abstract class ICartRepository {
  Future<CartResponse> addToCart(int productId);
  Future<CartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartItemEntity>> getcart();
}
