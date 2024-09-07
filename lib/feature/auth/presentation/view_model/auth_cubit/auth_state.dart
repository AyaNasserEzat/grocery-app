abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class SignInSuccess extends AuthState {}

final class UploadProfilePic extends AuthState {}

final class SignInLoading extends AuthState {}

final class SignInFailure extends AuthState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

////google
final class SignInGoogleSuccess extends AuthState {}

final class SignInGoogleLoading extends AuthState {}

final class SignInGoogleFailure extends AuthState {
  final String errMessage;

  SignInGoogleFailure({required this.errMessage});
}

final class SignUpSuccess extends AuthState {
  final String? message;

  SignUpSuccess({required this.message});
}

final class SignUpLoading extends AuthState {}

final class SignUpFailure extends AuthState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

final class ForgetPasswordLoading extends AuthState {}

final class ForgetPasswordSucess extends AuthState {
  final String message;

  ForgetPasswordSucess({required this.message});
}

final class ForgetPasswoedFailure extends AuthState {
  final String errMessage;

  ForgetPasswoedFailure({required this.errMessage});
}

// final class GetUserSuccess extends AuthState {
// }

// final class GetUserLoading extends AuthState {}

// final class GetUserFailure extends AuthState {
//   final String errMessage;

//   GetUserFailure({required this.errMessage});
// }
