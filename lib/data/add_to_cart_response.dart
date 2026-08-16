class AddToCartResponse {
  final int productId;
  final int cartItemId;
  final int count;

  AddToCartResponse(this.productId, this.count, this.cartItemId);
  AddToCartResponse.fromJson(Map<String, dynamic> json)
    : productId = json['product_id'],
      cartItemId = json['id'],
      count = json['count'];
}
