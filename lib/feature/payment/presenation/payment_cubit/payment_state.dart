abstract class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSucess extends PaymentState {}

final class PaymentFailure extends PaymentState {
  final String errMessage;

  PaymentFailure({required this.errMessage});
}
