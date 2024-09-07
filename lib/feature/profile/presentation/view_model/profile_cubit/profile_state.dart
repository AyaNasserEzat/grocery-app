abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

final class GetUserSuccess extends ProfileState {}

final class GetUserLoading extends ProfileState {}

final class GetUserFailure extends ProfileState {
  final String errMessage;

  GetUserFailure({required this.errMessage});
}

final class UpdateShippingAddSuccess extends ProfileState {}

final class UpdateShippingAddLoading extends ProfileState {}

final class UpdateShippingAddFailure extends ProfileState {
  final String errMessage;

  UpdateShippingAddFailure({required this.errMessage});
}

final class LoadingSignOutState extends ProfileState {}

final class SucessSignOutState extends ProfileState {}

final class FauilrSignOutState extends ProfileState {
  final String errMessage;

  FauilrSignOutState({required this.errMessage});
}
