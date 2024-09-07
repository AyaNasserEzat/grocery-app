import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/firebase_excption.dart';
import 'package:grocery_app/core/helper/cach_helper.dart';
import 'package:grocery_app/core/services/firebase_services.dart';
import 'package:grocery_app/core/services/services_locator.dart';
import 'package:grocery_app/feature/profile/data/models/user_model.dart';

class ProfileRepository {
  FirebaseServices firebaseServices;
  ProfileRepository(this.firebaseServices);
  Future<Either<String, UserModel?>> getUserData() async {
    try {
      final res = await firebaseServices.getUserData();
      return Right(UserModel.fromJson(res));
    } on FirebaseExcption catch (e) {
      print('error is ${e.message}');
      return Left(e.message);
    }
  }

  Future<Either<String, String>> updateShippingAdd(
      {required String shippingAdd}) async {
    try {
      final res =
          await firebaseServices.updateShippingAdd(shippingAdd: shippingAdd);
      return const Right('sucess');
    } on FirebaseExcption catch (e) {
      print('error is ${e.message}');
      return Left(e.message);
    }
  }

  Future<Either<String, String>> signOut() async {
    try {
      await firebaseServices.signOut();
      await sl<CacheHelper>().removeData(key: 'uuid');
      return const Right('sucess');
    } on FirebaseExcption catch (e) {
      // print('error is ${e.message}');
      return Left(e.message);
    }
  }
}
