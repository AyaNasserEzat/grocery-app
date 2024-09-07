import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/empty_screen.dart';
import 'package:grocery_app/feature/cart/presentation/view/widgets/cart_item.dart';
import 'package:grocery_app/feature/cart/presentation/view/widgets/row_cart.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_state.dart';
import 'package:iconly/iconly.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(listener: (context, state) {
      if (state is SuccessDeleteCartItem) {
        showSnakBar(context, 'product removed from cart', SnackBarType.info);
      }
    }, builder: (context, state) {
      CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
      if (cartCubit.cartModelList.isEmpty) {
        return const EmptyScreen(
          imageUrl: 'assets/images/emtyCart.jpeg',
          text: 'Your cart is empty',
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            title: Text(
              'Cart (${cartCubit.cartModelList.length})',
              style: const TextStyle(
                color: AppColors.green,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  cartCubit.clearCart();
                },
                icon: const Icon(
                  IconlyLight.delete,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: cartCubit.cartModelList.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      cartModel: cartCubit.cartModelList[index],
                    );
                  },
                ),
              ),
              const RowCart(),
            ],
          ),
        );
      }
    });
  }
}
