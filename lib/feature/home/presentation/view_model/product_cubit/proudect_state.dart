abstract class ProductState {}

class InitialProductState extends ProductState {}

class LoadingGetProductState extends ProductState {}

class SuccessGetProductState extends ProductState {}

class FailureGetProductState extends ProductState {
  final String message;
  FailureGetProductState(this.message);
}

class SuccessGetSearchProductState extends ProductState {}

class SuccessGetProductByNameState extends ProductState {}

class IncreaseProductQuntityByOnyState extends ProductState {}
