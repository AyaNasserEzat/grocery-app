import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/core/services/strip_service.dart';
import 'package:grocery_app/feature/payment/data/models/payment_initent_input_model.dart';

class CheckoutRepo {
  final StripService stripService = StripService();
  Future<Either<Failure, String>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
    await  stripService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right('sucess payment');
    } catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }
}
