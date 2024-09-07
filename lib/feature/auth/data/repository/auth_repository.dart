import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/core/error/firebase_excption.dart';
import 'package:grocery_app/core/services/firebase_services.dart';
import 'package:grocery_app/feature/profile/data/models/user_model.dart';

class AuthRepository {
  final FirebaseServices firebaseServices;
  AuthRepository(this.firebaseServices);
  Future<Either<String, UserCredential?>> signUp({
    required String name,
    required String email,
    required String password,
    required String shippingAdd,
  }) async {
    try {
      final res = await firebaseServices.signUp(
        email: email,
        password: password,
        name: name,
        shippingAdd: shippingAdd,
      );
      return Right(res);
    } on FirebaseExcption catch (e) {
      print('error is ${e.message}');
      return Left(e.message);
    }
  }

  Future<Either<String, String>> signIn(
      {required String email, required String password}) async {
    try {
      await firebaseServices.signIn(email: email, password: password);
      return right('sucess sign in');
    } on FirebaseExcption catch (e) {
      //  print('error is ${e.message}');
      return left(e.message);
    }
  }

  Future<Either<String, String>> restPassword({required String email}) async {
    try {
      await firebaseServices.resetPassword(email: email);
      return const Right('rest password Suess');
    } on FirebaseExcption catch (e) {
      // print('error is ${e.message}');
      return Left(e.message);
    }
  }

  Future<Either<String, UserModel?>> getUserData() async {
    try {
      final res = await firebaseServices.getUserData();
      return Right(UserModel.fromJson(res));
    } on FirebaseExcption catch (e) {
      print('error is ${e.message}');
      return Left(e.message);
    }
  }
}
