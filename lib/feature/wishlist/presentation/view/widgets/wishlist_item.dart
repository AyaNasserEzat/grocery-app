import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/wishlist/data/models/wishlist_model.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/whishlist_cubit.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({
    required this.wishlistModel,
    super.key,
  });
  final WishlistModel wishlistModel;
  @override
  Widget build(BuildContext context) {
    final ProductModdel getcurrentProduct =
        BlocProvider.of<ProductCubit>(context)
            .findProdById(wishlistModel.productId);
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.only(left: 7.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    getcurrentProduct.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  IconButton(
                    onPressed: () async {
                      await BlocProvider.of<WhishlistCubit>(context)
                          .removeFromWishList(
                        wishlistId: wishlistModel.wishlistId,
                        productId: wishlistModel.productId,
                      );
                      
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getcurrentProduct.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(getcurrentProduct.price.toString() + r'$'),
                      const SizedBox(width: 10,),
                  getcurrentProduct.isOnSale?    Text(getcurrentProduct.salePrice.toString() + r'$',style:const TextStyle(decoration: TextDecoration.lineThrough)):Container()
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
