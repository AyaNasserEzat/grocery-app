abstract class CartState {}

class CartInitial extends CartState {}

class LoadingAddToCart extends CartState {}

class SuccessAddedToCart extends CartState {}

class FailureAddToCart extends CartState {
  final String error;

  FailureAddToCart(this.error);
}

class LoadingGetCartItem extends CartState {}

class SuccessGetCartItem extends CartState {}

class FailureGetCartItem extends CartState {
  final String error;

  FailureGetCartItem(this.error);
}

class FailureNoUserFound extends CartState {
  final String error;

  FailureNoUserFound(this.error);
}

class LoadingDeleteCartItem extends CartState {}

class SuccessDeleteCartItem extends CartState {}

class FailureDeleteCartItem extends CartState {
  final String error;

  FailureDeleteCartItem(this.error);
}

class IncreaseQuntityByOnyState extends CartState {}

class LoadingIncreaseQuntityByOnyState extends CartState {}

class DecreaseQuntityByOnyState extends CartState {}

class ClearCartState extends CartState {}
