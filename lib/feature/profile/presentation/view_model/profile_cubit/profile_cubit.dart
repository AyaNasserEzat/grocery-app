import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/feature/profile/data/models/user_model.dart';
import 'package:grocery_app/feature/profile/data/repository/profile_repo.dart';

import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepository) : super(InitialProfileState());
  ProfileRepository profileRepository;
  TextEditingController shippingAdd = TextEditingController();
  UserModel? userModel;
  //////get user profile
  getUserData() async {
    emit(GetUserLoading());
    final res = await profileRepository.getUserData();
    res.fold((l) => emit(GetUserFailure(errMessage: l)), (r) {
      userModel = r;
      print(userModel!.email);
      emit(GetUserSuccess());
    });
  }

  ///update shipping address
  updateShippingAdd() async {
    emit(UpdateShippingAddLoading());
    final res = await profileRepository.updateShippingAdd(
        shippingAdd: shippingAdd.text);
    res.fold((l) => emit(UpdateShippingAddFailure(errMessage: l)), (r) {
      emit(UpdateShippingAddSuccess());
    });
  }

  signout() async {
    emit(LoadingSignOutState());
    final res = await profileRepository.signOut();
    res.fold((l) => emit(FauilrSignOutState(errMessage: l)),
        (r) => emit(SucessSignOutState()));
  }
  clearPofileState(){
    emit(InitialProfileState());
  }
}
