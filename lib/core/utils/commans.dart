import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/feature/auth/presentation/view/login_view.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_state.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/whishlist_cubit.dart';

void navigate(BuildContext context, Widget screen) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

Future<dynamic> showAddressDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
          return AlertDialog(
            title: const Text('address'),
            content: TextFormField(
              controller: BlocProvider.of<ProfileCubit>(context).shippingAdd,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'address',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await BlocProvider.of<ProfileCubit>(context)
                      .updateShippingAdd();

                  Navigator.pop(context);

                  BlocProvider.of<ProfileCubit>(context).getUserData();
                },
                child: const Text('update'),
              ),
            ],
          );
        });
      });
}

Future<dynamic> showSignOutDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('sigin out'),
          content: const Text('do you want sigin out?'),
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                  await BlocProvider.of<HomeCubit>(context).cleartHomeCubit();
                  await BlocProvider.of<CartCubit>(context).clearCartState();
                  await BlocProvider.of<WhishlistCubit>(context).clearwishListState();
                  await BlocProvider.of<ProductCubit>(context).clearState();
                  navigate(context, const LoginView());
              
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel '),
            ),
          ],
        );
      });
}

void showSnakBar(
    BuildContext context, String message, SnackBarType snackBarType) {
  ScaffoldMessenger.of(context).showSnackBar(
    customSnackBar(
      message: message,
      type: snackBarType,
    ),
  );
}
