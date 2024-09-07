import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/app/app.dart';
import 'package:grocery_app/core/helper/cach_helper.dart';
import 'package:grocery_app/core/services/services_locator.dart';
import 'package:grocery_app/core/utils/api_keys.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/order/presentation/view_model/order_cubit.dart';
import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/whishlist_cubit.dart';

import 'package:grocery_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initServiceLocator();
 Stripe.publishableKey = StripKeys.publishableKey;
  await sl<CacheHelper>().init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (contxt) => sl<HomeCubit>(),
      ),
      BlocProvider(
        create: (contxt) => sl<AuthCubit>(),
      ),
      BlocProvider(
        create: (contxt) => sl<ProfileCubit>()..getUserData(),
      ),
      BlocProvider(
        create: (contxt) => sl<ProductCubit>()..getProduct(),
      ),
      BlocProvider(
        create: (contxt) => sl<CartCubit>()..getCartItem(),
      ),
      BlocProvider(
        create: (contxt) => sl<WhishlistCubit>()..getWishListItem(),
      ),
      BlocProvider(
        create: (contxt) => sl<OrderCubit>()..getOrder(),
      ),
    ],
    child: const MyApp(),
  ));
}
