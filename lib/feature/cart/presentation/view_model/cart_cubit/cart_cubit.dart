import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/feature/cart/data/models/cart_model.dart';

import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_state.dart';
import 'package:uuid/uuid.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final FirebaseAuth authInstance = FirebaseAuth.instance;
  Map<String, int> quantityOfProducts = {};
  Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    final User? user = authInstance.currentUser;
    if (user == null) {
      emit(FailureNoUserFound('User is not authenticated'));
      return;
    }

    try {
      emit(LoadingAddToCart());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': const Uuid().v4(),
            'productId': productId,
            'quantity': quantity,
          }
        ]),
      });
      await getCartItem();
      emit(SuccessAddedToCart());
    } catch (error) {
      emit(FailureAddToCart(error.toString()));
    }
  }

  List<CartModel> cartModelList = [];
  //feach cart
  getCartItem() async {
    final User? user = authInstance.currentUser;
    if (user == null) {
      emit(FailureNoUserFound('User is not authenticated'));
      return;
    }
    try {
      emit(LoadingGetCartItem());
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final List<dynamic> cartData = userDoc.get('userCart');
      cartModelList = cartData
          .map(
            (e) => CartModel.fromFirebase(e),
          )
          .toList();
      emit(SuccessGetCartItem());
    } on FirebaseException catch (error) {
      emit(FailureGetCartItem(error.toString()));
    }
  }

  //
  Future<void> removeFromCart({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    final User? user = authInstance.currentUser;
    try {
      emit(LoadingDeleteCartItem());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'userCart': FieldValue.arrayRemove([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
      cartModelList.removeWhere((e) => e.productId == productId);
      await getCartItem();

      emit(SuccessDeleteCartItem());
    } on FirebaseException catch (e) {
      emit(FailureDeleteCartItem(e.toString()));
    }
  }

//inrease quintity by 1
  increaseQuntityByOny({
    required String productId,
  }) async {
    final User? user = authInstance.currentUser;
    final cartModel = cartModelList.firstWhere((e) => e.productId == productId);
    cartModel.quantity = (cartModel.quantity) + 1;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'userCart': (cartModelList.map((e) => e.toMap()))});
    emit(IncreaseQuntityByOnyState());
  }

//decrease quintity by 1
  decreaseQuntityByOny({required String productId}) async {
    final User? user = authInstance.currentUser;
    final cartModel = cartModelList.firstWhere((e) => e.productId == productId);
    if (cartModel.quantity != 1) {
      cartModel.quantity = (cartModel.quantity) - 1;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'userCart': (cartModelList.map((e) => e.toMap()))});
    }
    emit(DecreaseQuntityByOnyState());
  }

//find cartModel id from product id
  getCartModelIdByproductId(String productId) {
    return cartModelList.firstWhere((e) => e.productId == productId);
  }

  //check is in cart
  bool isInCartItem(String productId) {
    return cartModelList.any((e) => e.productId == productId);
  }

  clearCart() async {
    final User? user = authInstance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'userCart': []});
    cartModelList.clear();
    quantityOfProducts.clear();
    emit(ClearCartState());
  }
    clearCartState(){
    emit(CartInitial());
  }
}
