import 'package:get_it/get_it.dart';
import 'package:grocery_app/core/helper/cach_helper.dart';
import 'package:grocery_app/core/services/firebase_services.dart';
import 'package:grocery_app/feature/auth/data/repository/auth_repository.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/order/presentation/view_model/order_cubit.dart';
import 'package:grocery_app/feature/profile/data/repository/profile_repo.dart';
import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/whishlist_cubit.dart';

final sl = GetIt.instance;
void initServiceLocator() {
  sl.registerLazySingleton(() => AuthRepository(sl()));
  sl.registerLazySingleton(() => ProfileRepository(sl()));
  sl.registerLazySingleton(() => FirebaseServices());
  sl.registerLazySingleton(() => HomeCubit());
  sl.registerLazySingleton(() => CacheHelper());
  sl.registerLazySingleton(() => ProductCubit());
  sl.registerLazySingleton(() => CartCubit());
  sl.registerLazySingleton(() => WhishlistCubit());
  sl.registerLazySingleton(() => OrderCubit());
  sl.registerLazySingleton(() => AuthCubit(sl()));
  sl.registerLazySingleton(() => ProfileCubit(sl()));
}
