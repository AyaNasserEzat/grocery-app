class PaymentIntentInputModel {
  final double amount;
  final String currency;

  PaymentIntentInputModel({required this.amount, required this.currency});
  toJson() {
    return {
      'amount': (amount*100).round(),
      'currency': currency,
    };
  }
}
