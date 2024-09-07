abstract class OrderState {}

class InitialOrderState extends OrderState {}

class LoadingAddOrderState extends OrderState {}

class SuccessAddOrderState extends OrderState {}

class FailureAddOrderState extends OrderState {
  final String message;
  FailureAddOrderState(this.message);
}

class LoadingGetOrderState extends OrderState {}

class SuccessGetOrderState extends OrderState {}

class FailureGetOrderState extends OrderState {
  final String message;
  FailureGetOrderState(this.message);
}
