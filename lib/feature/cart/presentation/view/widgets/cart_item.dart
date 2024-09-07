import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/feature/cart/data/models/cart_model.dart';
import 'package:grocery_app/feature/cart/presentation/view/widgets/row_plus_minus.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required this.cartModel,
    super.key,
  });
  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final ProductModdel getcurrentProduct =
        BlocProvider.of<ProductCubit>(context)
            .findProdById(cartModel.productId);
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                getcurrentProduct.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getcurrentProduct.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${(getcurrentProduct.isOnSale ? getcurrentProduct.salePrice : getcurrentProduct.price) * cartModel.quantity} ',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RowPlusMinus(productModdel: getcurrentProduct),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  await BlocProvider.of<CartCubit>(context).removeFromCart(
                      cartId: cartModel.cartId,
                      productId: cartModel.productId,
                      quantity: cartModel.quantity);
                },
                icon: const Icon(
                  CupertinoIcons.cart_badge_minus,
                  color: AppColors.green,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
