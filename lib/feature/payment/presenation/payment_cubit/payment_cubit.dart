import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/feature/payment/data/models/payment_initent_input_model.dart';
import 'package:grocery_app/feature/payment/data/repository/checkout_repo.dart';
import 'package:grocery_app/feature/payment/presenation/payment_cubit/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  CheckoutRepo checkoutRepo = CheckoutRepo();
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold((l) => emit(PaymentFailure(errMessage: l.errMessage)), (r) => emit(PaymentSucess()));
  }
}
