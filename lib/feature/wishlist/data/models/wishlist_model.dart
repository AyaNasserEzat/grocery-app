class WishlistModel {
  final String wishlistId;
  final String productId;

  WishlistModel({
    required this.wishlistId,
    required this.productId,
  });
  factory WishlistModel.fromFirebase(Map<String, dynamic> snapshot) {
    return WishlistModel(
      wishlistId: snapshot['wishlistId'],
      productId: snapshot['productId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wishlistId': wishlistId,
      'productId': productId,
    };
  }
}
