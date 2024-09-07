import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/utils/constants.dart';
import 'package:grocery_app/core/widgets/custom_loading.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/feature/auth/presentation/view/signUp_view.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_state.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/custom_btn.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/btn_sign_with_google.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/custom_textformfield.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/forget_password_text.dart';
import 'package:grocery_app/feature/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view/bottomVavigtion.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/feature/wishlist/presentation/whishlist_cubit/whishlist_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is SignInSuccess) {
            await BlocProvider.of<ProductCubit>(context).getProduct();
            await BlocProvider.of<ProfileCubit>(context).getUserData();
            await BlocProvider.of<CartCubit>(context).getCartItem();
            await BlocProvider.of<WhishlistCubit>(context).getWishListItem();
            showSnakBar(context, 'Login successfully', SnackBarType.success);
            navigate(context, const BottomvavigtionView());
          }
          if (state is SignInFailure) {
            showSnakBar(context, state.errMessage, SnackBarType.error);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Swiper(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Constants.offerImageList[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
              ),
              Container(
                color: Colors.black.withOpacity(.7),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 120,
                      ),
                      const Text(
                        'Welcome back',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                      const Text(
                        'Sign in to continue',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller:
                            BlocProvider.of<AuthCubit>(context).signInEmail,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller:
                            BlocProvider.of<AuthCubit>(context).signInPassword,
                        hintText: 'Password',
                       isPassword: true,
                      ),
                      const ForgetPasswordText(),
                      CustomBtn(
                        backgroundColor: AppColors.grey,
                        text: 'Sign In',
                        onPressed: () async {
                          await BlocProvider.of<AuthCubit>(context).signIn();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const BtnSignWithGoogle(),
                   //   const ORRow(),
                      Row(
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          TextButton(
                            onPressed: () {
                              navigate(context, const SignupView());
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  decorationColor: Colors.blue,
                                  color: Colors.blue,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (state is SignInLoading) const CustomLoading()
            ],
          );
        },
      ),
    );
  }
}
