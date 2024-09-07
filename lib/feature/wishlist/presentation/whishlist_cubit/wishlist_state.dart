abstract class WishListState {}

class WishlistInitial extends WishListState {}

class LoadingAddToWishList extends WishListState {}

class SuccessAddedToWishList extends WishListState {}

class FailureAddToWishList extends WishListState {
  final String error;

  FailureAddToWishList(this.error);
}

class LoadingGetWishListItem extends WishListState {}

class SuccessGetWishListItem extends WishListState {}

class FailureGetWishListItem extends WishListState {
  final String error;

  FailureGetWishListItem(this.error);
}

class FailureNoUserFoundWishList extends WishListState {
  final String error;

  FailureNoUserFoundWishList(this.error);
}

class LoadingDeleteWishListItem extends WishListState {}

class SuccessDeleteWishListItem extends WishListState {}

class FailureDeleteWishListItem extends WishListState {
  final String error;

  FailureDeleteWishListItem(this.error);
}

class ClearWishListState extends WishListState {}
