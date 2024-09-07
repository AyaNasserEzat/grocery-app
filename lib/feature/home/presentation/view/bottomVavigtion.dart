import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/home_state.dart';

class BottomvavigtionView extends StatelessWidget {
  const BottomvavigtionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
      return Scaffold(
        body: homeCubit.screens[homeCubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,//const Color(0xff00784a),
          currentIndex: homeCubit.currentIndex,
          onTap: (value) {
            homeCubit.changeIndx(value);
          },
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.green,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'card'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
        ),
      );
    });
  }
}
