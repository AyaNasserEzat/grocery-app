import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId, userId, productId, userName, imageUrl;
  int price, quantity;
  final Timestamp orderDate;

  OrderModel(
      {required this.orderId,
      required this.userId,
      required this.productId,
      required this.userName,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.orderDate});
  factory OrderModel.fromMap(DocumentSnapshot data) {
    return OrderModel(
      orderId: data['orderId'],
      userId: data['userId'],
      productId: data['productId'],
      userName: data['userName'],
      price: data['price'],
      imageUrl: data['imageUrl'],
      quantity: data['quantity'],
      orderDate: data['orderDate'],
    );
  }
}
