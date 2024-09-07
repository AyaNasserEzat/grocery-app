import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String id;
  final String shippingAdd;
  final String email;

  const UserModel(
      {required this.name,
      required this.id,
      required this.shippingAdd,
      required this.email});

  factory UserModel.fromJson(DocumentSnapshot doc) {
    return UserModel(
      name: doc.get('name'),
      id: doc.get('id'),
      shippingAdd: doc.get('shipping_add'),
      email: doc.get('email'),
    );
  }
}
