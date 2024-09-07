import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/feature/cart/data/models/cart_model.dart';
import 'package:grocery_app/feature/cart/presentation/view/widgets/btn.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_state.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';

class RowPlusMinus extends StatelessWidget {
  const RowPlusMinus({
    required this.productModdel,
    super.key,
  });
  final ProductModdel productModdel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      final CartModel cartModel = BlocProvider.of<CartCubit>(context)
          .getCartModelIdByproductId(productModdel.id);
      return Row(
        children: [
          butn(
            onTap: () {
              BlocProvider.of<CartCubit>(context).increaseQuntityByOny(
                productId: cartModel.productId,
              );
            },
            icon: Icons.add,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            '${cartModel.quantity} ${productModdel.isPiece}',
            style: const TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const SizedBox(
            width: 8,
          ),
          butn(
            onTap: () {
              BlocProvider.of<CartCubit>(context).decreaseQuntityByOny(
                productId: cartModel.productId,
              );
            },
            icon: CupertinoIcons.minus,
          ),
        ],
      );
    });
  }
}
