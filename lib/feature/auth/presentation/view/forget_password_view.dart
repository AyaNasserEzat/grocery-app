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

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgetPasswoedFailure) {
            showSnakBar(context, state.errMessage, SnackBarType.error);
          } else if (state is ForgetPasswordSucess) {
            showSnakBar(context, state.message, SnackBarType.success);
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        navigate(context, const LoginView());
                      },
                    ),
                    const Text(
                      'Forget password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'Email Address',
                      controller: BlocProvider.of<AuthCubit>(context)
                          .forgetPasswordEmail,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomBtn(
                      backgroundColor: Colors.grey[400],
                      text: 'Reset Password',
                      onPressed: () async {
                        await BlocProvider.of<AuthCubit>(context)
                            .restPassword();
                      },
                    ),
                  ],
                ),
              ),
              if (state is ForgetPasswordLoading) const CustomLoading()
            ],
          );
        },
      ),
    );
  }
}
