import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_state.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view/bottomVavigtion.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/whishlist_cubit.dart';

class BtnSignWithGoogle extends StatelessWidget {
  const BtnSignWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) async{
      if (state is SignInGoogleFailure) {
        showSnakBar(context, state.errMessage, SnackBarType.error);
      }
      if (state is SignInGoogleSuccess) {
                   await BlocProvider.of<ProductCubit>(context).getProduct();
            await BlocProvider.of<ProfileCubit>(context).getUserData();
            await BlocProvider.of<CartCubit>(context).getCartItem();
            await BlocProvider.of<WhishlistCubit>(context).getWishListItem();
        showSnakBar(context, 'login suecessfully', SnackBarType.success);
        navigate(context, const BottomvavigtionView());
      }
    }, builder: (context, state) {
      return InkWell(
        onTap: () async {
          await BlocProvider.of<AuthCubit>(context).signInWithGoogle();
         
        },
        child: Material(
          color: Colors.blue,
          child: Row(
            children: [
              Container(
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/google.png',
                    width: 40,
                    height: 40,
                  )),
              const SizedBox(
                width: 7,
              ),
              const Text(
                'sign in with Google',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      );
    });
  }
}
