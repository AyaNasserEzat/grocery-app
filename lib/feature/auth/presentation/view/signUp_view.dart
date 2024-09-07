import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/utils/constants.dart';
import 'package:grocery_app/core/widgets/custom_loading.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/feature/auth/presentation/view/login_view.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:grocery_app/feature/auth/presentation/view_model/auth_cubit/auth_state.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/custom_btn.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/custom_textformfield.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/forget_password_text.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            showSnakBar(context, state.errMessage, SnackBarType.error);
          } else if (state is SignUpSuccess) {
            showSnakBar(context, 'Sign up successfully', SnackBarType.success);
            navigate(context, const LoginView());
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
                      const SizedBox(height: 120),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                      const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: 'Full name',
                        controller:
                            BlocProvider.of<AuthCubit>(context).signUpname,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: 'Email',
                        controller:
                            BlocProvider.of<AuthCubit>(context).signUpEmail,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: 'Password',
                        controller:
                            BlocProvider.of<AuthCubit>(context).signUpPassword,
                       isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: 'Shipping address',
                        controller: BlocProvider.of<AuthCubit>(context)
                            .signUpshippingAdd,
                      ),
                      const ForgetPasswordText(),
                      CustomBtn(
                        backgroundColor: Colors.grey[400],
                        text: 'Sign up',
                        onPressed: () async {
                          await BlocProvider.of<AuthCubit>(context).signUp();
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Already a user?',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          TextButton(
                            onPressed: () {
                              navigate(context, const LoginView());
                            },
                            child: const Text(
                              'Sign In',
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
              if (state is SignUpLoading) const CustomLoading()
            ],
          );
        },
      ),
    );
  }
}
