class CartResponse {
  final int productId;
  final int cartItemId;
  final int count;

  CartResponse(this.productId, this.count, this.cartItemId);
  CartResponse.fromJson(Map<String, dynamic> json)
    : productId = json['product_id'],
      cartItemId = json['id'],
      count = json['count'];
}
