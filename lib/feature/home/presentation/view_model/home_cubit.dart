import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/feature/cart/presentation/view/cart_view.dart';
import 'package:grocery_app/feature/home/presentation/view/category_view.dart';
import 'package:grocery_app/feature/home/presentation/view_model/home_state.dart';
import 'package:grocery_app/feature/home/presentation/view/home_view.dart';
import 'package:grocery_app/feature/profile/presentation/screens/profile_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeView(),
    const CategoryScreen(),
    const CartView(),
    const ProfileScreen(),
  ];
  void changeIndx(int indx) {
    currentIndex = indx;
    emit(ChangeIndxState());
  }
  cleartHomeCubit(){
    currentIndex=0;
    emit(InitialHomeState());
  }
}
