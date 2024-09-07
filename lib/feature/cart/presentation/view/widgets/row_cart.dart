import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/core/widgets/elvated_btn.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_state.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/order/presentation/view_model/order_cubit.dart';
import 'package:grocery_app/feature/payment/data/models/payment_initent_input_model.dart';
import 'package:grocery_app/feature/payment/data/repository/checkout_repo.dart';
import 'package:grocery_app/feature/payment/presenation/payment_cubit/payment_cubit.dart';
import 'package:grocery_app/feature/payment/presenation/payment_cubit/payment_state.dart';

class RowCart extends StatelessWidget {
  const RowCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      double total = 0.0;
      var cartList = BlocProvider.of<CartCubit>(context).cartModelList;
      for (var i in cartList) {
        final ProductModdel getcurrentProduct =
            BlocProvider.of<ProductCubit>(context).findProdById(i.productId);
        total += (getcurrentProduct.isOnSale
                ? getcurrentProduct.salePrice
                : getcurrentProduct.price) *
            i.quantity;
      }
      return Material(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocProvider(
                create: (context) => PaymentCubit(CheckoutRepo()),
                child: BlocConsumer<PaymentCubit, PaymentState>(
                    listener: (context, state) async{
                  if (state is PaymentSucess) {
                    for (var i in cartList) {
                      final ProductModdel getcurrentProduct =
                          BlocProvider.of<ProductCubit>(context)
                              .findProdById(i.productId);
                   await   BlocProvider.of<OrderCubit>(context).addOrder(
                          cartModel: i,
                          total: total,
                          getcurrentProduct: getcurrentProduct);
                    }
                   await BlocProvider.of<CartCubit>(context).clearCart();
                    showSnakBar(context, 'your order have been placed',
                        SnackBarType.success);
                  }
                  if (state is PaymentFailure) {
                    showSnakBar(context, ' The payment flow has been canceled',
                        SnackBarType.error);
                  }
                }, builder: (context, state) {
                  return ElvatedButon(
                    text: 'order now',
                    onPressed: () async {
                      PaymentIntentInputModel paymentIntentInputModel =
                          PaymentIntentInputModel(
                              amount: total, currency: 'USD');
                      await BlocProvider.of<PaymentCubit>(context).makePayment(
                          paymentIntentInputModel: paymentIntentInputModel);
                    },
                  );
                }),
              ),
              Column(
                children: [
                  const Text(
                    'Total price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: AppColors.grey),
                  ),
                  Text(
                    total.toStringAsFixed(2),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: AppColors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
