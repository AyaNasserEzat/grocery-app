import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/feature/cart/data/models/cart_model.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/order/data/models/order_model.dart';
import 'package:grocery_app/feature/order/presentation/view_model/order_state.dart';
import 'package:uuid/uuid.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(InitialOrderState());

  final User? user = FirebaseAuth.instance.currentUser;
  addOrder(
      {required CartModel cartModel,
      required double total,
      required ProductModdel getcurrentProduct}) async {
    try {
      emit(LoadingAddOrderState());
      final orderId = const Uuid().v4();
      await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'userId': user!.uid,
        'productId': cartModel.productId,
        'price': getcurrentProduct.price,
        'totalPrice': total,
        'quantity': cartModel.quantity,
        'imageUrl': getcurrentProduct.imageUrl,
        'userName': user!.displayName,
        'orderDate': Timestamp.now(),
      });

      getOrder();
      emit(SuccessAddOrderState());
    } on FirebaseException catch (e) {
      emit(FailureAddOrderState(e.message!));
    }
  }

  List<OrderModel> orderList = [];
  List<OrderModel> orderUserList = [];
  OrderModel? orderModel;
  getOrder() async {
    try {
      emit(LoadingGetOrderState());
      final snapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      orderList = snapshot.docs.map((doc) => OrderModel.fromMap(doc)).toList();
      //get order by user id
      orderUserList = orderList.where((e) => e.userId == user!.uid).toList();
      emit(SuccessGetOrderState());
    } on FirebaseException catch (e) {
      emit(FailureGetOrderState(e.toString()));
    }
  }
}
