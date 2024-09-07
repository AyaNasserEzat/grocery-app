import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/wishlist/data/models/wishlist_model.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/whishlist_cubit.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/wishlist_state.dart';

class HeartBtn extends StatelessWidget {
  const HeartBtn({
    super.key,
    required this.productModdel,
  });

  final ProductModdel productModdel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WhishlistCubit, WishListState>(
      listener: (context, state) {
      },
        builder: (context, state) {
      final ProductModdel getcurrentProduct =
          BlocProvider.of<ProductCubit>(context).findProdById(productModdel.id);
      final bool isInwishList = BlocProvider.of<WhishlistCubit>(context)
          .isInWishList(getcurrentProduct.id);
      return GestureDetector(
        onTap: () async {
          if (isInwishList) {
            final WishlistModel wishlistModel =
                BlocProvider.of<WhishlistCubit>(context)
                    .getWishListIdByproductId(getcurrentProduct.id);

            await BlocProvider.of<WhishlistCubit>(context).removeFromWishList(
                productId: getcurrentProduct.id,
                wishlistId: wishlistModel.wishlistId);
                showSnakBar(context, 'product removed to wishlist', SnackBarType.info);
          } else {
            await BlocProvider.of<WhishlistCubit>(context).addToWishList(
              productId: productModdel.id,
            );
             showSnakBar(context, 'product added to wishlist', SnackBarType.info);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              isInwishList ? Icons.favorite : Icons.favorite_border_outlined,
              size: 20,
              color: AppColors.green,
            ),
          ),
        ),
      );
    });
  }
}
