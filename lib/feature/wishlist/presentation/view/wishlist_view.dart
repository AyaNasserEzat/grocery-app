import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_gridview.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/empty_screen.dart';
import 'package:grocery_app/feature/home/presentation/view/bottomVavigtion.dart';
import 'package:grocery_app/feature/wishlist/presentation/view/widgets/wishlist_item.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/whishlist_cubit.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/wishlist_state.dart';
import 'package:iconly/iconly.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WhishlistCubit, WishListState>(
        listener: (context, state) {
      if (state is SuccessDeleteWishListItem) {
        showSnakBar(context, 'product removed from wishlist', SnackBarType.info);
      }
    }, builder: (context, state) {
      WhishlistCubit whishlistCubit = BlocProvider.of<WhishlistCubit>(context);
      if (whishlistCubit.wishListModel.isEmpty) {
        return const EmptyScreen(
          imageUrl: 'assets/images/emptywishList.jpeg',
          text: 'your wishList is empty',
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            title: const Text(
              ' wishList ',
              style: TextStyle(color: AppColors.green),
            ),
            leading: IconButton(
              onPressed: () {
                navigate(context, const BottomvavigtionView());
              },
              icon: const Icon(
                IconlyLight.arrow_left,
                color: AppColors.green,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomGridView(
                    itemBuilder: (context, index) {
                      return WishlistItem(
                          wishlistModel: whishlistCubit.wishListModel[index]);
                    },
                    itemCount: whishlistCubit.wishListModel.length,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
