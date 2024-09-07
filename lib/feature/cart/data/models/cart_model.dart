class CartModel {
  final String cartId;
  final String productId;
  int quantity;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });
  factory CartModel.fromFirebase(Map<String, dynamic> snapshot) {
    return CartModel(
        cartId: snapshot['cartId'],
        productId: snapshot['productId'],
        quantity: snapshot['quantity']);
  }

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
