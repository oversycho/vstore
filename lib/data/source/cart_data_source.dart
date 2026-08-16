import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:vstore/common/http_client.dart';
import 'package:vstore/data/cart_item.dart';
import 'package:vstore/data/add_to_cart_response.dart';
import 'package:vstore/data/cart_response.dart';
import 'package:vstore/data/repo/cart_repository.dart'; // <-- new import, adjust path

final cartReposiorty = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartDataSource {
  Future<AddToCartResponse> addToCart(int productId);
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getcart();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);
  @override
  Future<AddToCartResponse> addToCart(int productId) async {
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
    return AddToCartResponse.fromJson(data);
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
  Future<CartResponse> getcart() async {
    final response = await httpClient.post('rpc/get_cart');
    debugPrint('RAW CART RESPONSE: ${response.data}'); // <-- this line
    return CartResponse.fromJson(response.data);
  }
}
