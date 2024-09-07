import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/core/widgets/elvated_btn.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_state.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';

class BtnAddToCart extends StatelessWidget {
  const BtnAddToCart({
    super.key,
    required this.productModdel,
    required this.quantity,
  });

  final ProductModdel productModdel;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      bool isInCart =
          BlocProvider.of<CartCubit>(context).isInCartItem(productModdel.id);
      return ElvatedButon(
        text: isInCart ? 'in Cart' : 'Add to Cart',
        onPressed: () async {
          if (!isInCart) {
            await BlocProvider.of<CartCubit>(context).addToCart(
              productId: productModdel.id,
              quantity: quantity,
            );
            showSnakBar(context, 'product added to cart', SnackBarType.info);
          }
        },
      );
    });
  }
}
