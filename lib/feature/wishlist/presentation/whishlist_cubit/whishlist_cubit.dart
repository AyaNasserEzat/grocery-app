import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/feature/wishlist/data/models/wishlist_model.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/wishlist_state.dart';
import 'package:uuid/uuid.dart';

class WhishlistCubit extends Cubit<WishListState> {
  WhishlistCubit() : super(WishlistInitial());

  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<void> addToWishList({
    required String productId,
  }) async {
    final User? user = authInstance.currentUser;
    if (user == null) {
      emit(FailureNoUserFoundWishList('User is not authenticated'));
      return;
    }

    try {
      emit(LoadingAddToWishList());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'wishList': FieldValue.arrayUnion([
          {
            'wishlistId': const Uuid().v4(),
            'productId': productId,
          }
        ]),
      });
      getWishListItem();
      emit(SuccessAddedToWishList());
    } catch (error) {
      emit(FailureAddToWishList(error.toString()));
    }
  }

  List<WishlistModel> wishListModel = [];
  //feach cart
  getWishListItem() async {
    final User? user = authInstance.currentUser;
    if (user == null) {
      emit(FailureNoUserFoundWishList('User is not authenticated'));
      return;
    }
    try {
      emit(LoadingGetWishListItem());
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final List<dynamic> wishData = userDoc.get('wishList');
      wishListModel = wishData
          .map(
            (e) => WishlistModel.fromFirebase(e),
          )
          .toList();
      emit(SuccessGetWishListItem());
    } on FirebaseException catch (error) {
      emit(FailureGetWishListItem(error.toString()));
    }
  }

  //
  Future<void> removeFromWishList({
    required String wishlistId,
    required String productId,
  }) async {
    final User? user = authInstance.currentUser;
    try {
      emit(LoadingDeleteWishListItem());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'wishList': FieldValue.arrayRemove([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      wishListModel.removeWhere((e) => e.productId == productId);
      await getWishListItem();
      emit(SuccessDeleteWishListItem());
    } on FirebaseException catch (e) {
      emit(FailureDeleteWishListItem(e.toString()));
    }
  }

  clearWishLisList() async {
    final User? user = authInstance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'wishList': []});
    wishListModel.clear();
    emit(ClearWishListState());
  }

  //chect is in wishList
  bool isInWishList(String productId) {
    return wishListModel.any((e) => e.productId == productId);
  }

//find wishlist id from product id
  getWishListIdByproductId(String productId) {
    return wishListModel.firstWhere((e) => e.productId == productId);
  }
  clearwishListState(){
    emit(WishlistInitial());
  }
}
