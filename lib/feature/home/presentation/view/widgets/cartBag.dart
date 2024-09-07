import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/feature/cart/data/models/cart_model.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_state.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:iconly/iconly.dart';

class Cartbag extends StatelessWidget {
  const Cartbag({
    super.key,
    required this.productModdel,
  });

  final ProductModdel productModdel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          final bool isInCart = BlocProvider.of<CartCubit>(context)
              .isInCartItem(productModdel.id);

          return GestureDetector(
            onTap: () async {
              if (!isInCart) {
                await BlocProvider.of<CartCubit>(context).addToCart(
                  productId: productModdel.id,
                  quantity: 1,
                );
                showSnakBar(context, 'product added to cart', SnackBarType.info);
              } else {
                CartModel? cartModel = BlocProvider.of<CartCubit>(context)
                    .getCartModelIdByproductId(productModdel.id);
                await BlocProvider.of<CartCubit>(context).removeFromCart(
                  cartId: cartModel!.cartId,
                  productId: productModdel.id,
                  quantity: cartModel.quantity,
                );
                showSnakBar(context, 'product removed from cart', SnackBarType.info);
              }
            },
            child: Icon(
              isInCart ? IconlyBold.bag_2 : IconlyLight.bag_2,
              size: 22,
              color: AppColors.green,
            ),
          );
        });
  }
}
