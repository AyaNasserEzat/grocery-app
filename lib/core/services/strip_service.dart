import 'dart:async';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/core/services/api_sevice.dart';
import 'package:grocery_app/core/utils/api_keys.dart';
import 'package:grocery_app/feature/payment/data/models/payment_initent_input_model.dart';
import 'package:grocery_app/feature/payment/data/models/payment_intent_model/payment_intent_model.dart';

class StripService {
  ApiSevice apiSevice = ApiSevice();
  Future<PaymentIntentModel> creatPaymentIntent(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var response = await apiSevice.post(
      body: paymentIntentInputModel.toJson(),
      contentType:'application/x-www-form-urlencoded',
      url: 'https://api.stripe.com/v1/payment_intents',
      token: StripKeys.secretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: 'aya',
    ));
  }

  Future displayPaymentSheet() async {
    // try {
  await Stripe.instance.presentPaymentSheet();
// } on Exception catch (e) {
//  print(e.toString());
// }
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await creatPaymentIntent(
        paymentIntentInputModel: paymentIntentInputModel);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
