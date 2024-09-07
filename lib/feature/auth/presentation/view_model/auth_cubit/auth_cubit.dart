import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/feature/auth/data/repository/auth_repository.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.authRepository,
  ) : super(AuthInitial());
  AuthRepository authRepository;

  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpname = TextEditingController();
  TextEditingController signUpshippingAdd = TextEditingController();
  TextEditingController forgetPasswordEmail = TextEditingController();
////sign up
  signUp() async {
    emit(SignUpLoading());

    final res = await authRepository.signUp(
      email: signUpEmail.text,
      password: signUpEmail.text,
      name: signUpname.text,
      shippingAdd: signUpshippingAdd.text,
    );
    res.fold((l) => emit(SignUpFailure(errMessage: l)), (r) {
      emit(SignUpSuccess(message: 'created acount sucessfully'));
    });
  }

  ////sign In
  signIn() async {
    emit(SignInLoading());
    final res = await authRepository.signIn(
        email: signInEmail.text, password: signInPassword.text);
    res.fold((l) => emit(SignInFailure(errMessage: l)), (r) async {
      emit(SignInSuccess());
    });
  }

  /////forget password
  restPassword() async {
    emit(ForgetPasswordLoading());
    final res =
        await authRepository.restPassword(email: forgetPasswordEmail.text);
    res.fold(
        (l) => emit(ForgetPasswoedFailure(errMessage: l)),
        (r) => emit(ForgetPasswordSucess(
            message: 'check your email to rest password')));
  }

  ////////////////goggle sign in
  Future signInWithGoogle() async {
    try {
      emit(SignInGoogleLoading());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final authReslut =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (authReslut.additionalUserInfo!.isNewUser) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authReslut.user!.uid)
            .set({
          'id': authReslut.user!.uid,
          'name': authReslut.user!.displayName,
          'email': authReslut.user!.email,
          'shipping_add': '',
          'wishList': [],
          'userCart': [],
          'createdAt': Timestamp.now(),
        });
      
      }
        emit(SignInGoogleSuccess());
    } on FirebaseException catch (e) {
      emit(SignInGoogleFailure(errMessage: e.toString()));
    }
  }
}
