import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/core/error/firebase_excption.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;

  Future signIn({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      getUserData();
      return result;
    } on FirebaseAuthException catch (e) {
      _handleFirebaseException(e);
    }
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
    String? shippingAdd,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = _auth.currentUser;
      final uid = user!.uid;
      await user.updateDisplayName(name);
      await user.reload();
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': uid,
        'name': name,
        'email': email,
        'shipping_add': shippingAdd,
        'wishList': [],
        'userCart': [],
        'createdAt': Timestamp.now(),
      });
      return result;
    } on FirebaseAuthException catch (e) {

      _handleFirebaseException(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      _handleFirebaseException(e);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseException(e);
    }
  }

  Future getUserData() async {
    try {
      final User? user = _auth.currentUser;
      final uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      return userDoc;
    } on FirebaseAuthException catch (e) {
      _handleFirebaseException(e);
    }
  }

  //update shipping
  Future updateShippingAdd({
    required String shippingAdd,
  }) async {
    try {
      final User? user = _auth.currentUser;
      final uid = user!.uid;
      final updatedShipping = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'shipping_add': shippingAdd});

      return updatedShipping;
    } on FirebaseAuthException catch (e) {
      _handleFirebaseException(e);
    }
  }

  _handleFirebaseException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        throw InvalidEmailOrPasswordException('invalid email or password');
      case 'weak-password':
        throw WeakPasswordException('weak password');
      case 'invalid-email':
        throw InvalidEmailException('The email address is not valid.');
      case 'user-disabled':
        throw UserDisabledException('User is disabled.');
      case 'user-not-found':
        throw UserNotFoundException('No user found for this email.');
      case 'wrong-password':
        throw WrongPasswordException('Incorrect password.');
      case 'email-already-in-use':
        throw EmailAlreadyInUseException('Email is already in use.');
      case 'The email address is already in use by another account':
        throw EmailAlreadyInUseException('Email is already in use.');
      case 'operation-not-allowed':
        throw OperationNotAllowedException('Operation not allowed.');

      default:
        throw UnknownFirebaseException('An unknown error occurred.');
    }
  }
}
