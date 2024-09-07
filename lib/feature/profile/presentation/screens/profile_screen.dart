import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/feature/auth/presentation/view/forget_password_view.dart';
import 'package:grocery_app/feature/order/presentation/view/order_view.dart';
import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/feature/profile/presentation/view_model/profile_cubit/profile_state.dart';
import 'package:grocery_app/feature/profile/presentation/widgets/custom_ListTile.dart';
import 'package:grocery_app/feature/wishlist/presentation/view/wishlist_view.dart';
import 'package:iconly/iconly.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetUserSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          'Hi, ${BlocProvider.of<ProfileCubit>(context).userModel!.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                          ),
                        ),
                        Text(
                          BlocProvider.of<ProfileCubit>(context)
                              .userModel!
                              .email,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        CustomListTile(
                          leading: IconlyLight.profile,
                          title: 'address',
                          subtitle: BlocProvider.of<ProfileCubit>(context)
                              .userModel!
                              .shippingAdd,
                          onPressed: () {
                            showAddressDialog(context);
                          },
                        ),
                        CustomListTile(
                          leading: IconlyLight.bag,
                          title: 'order',
                          onPressed: () {
                            navigate(context, const OrdersScreen());
                          },
                        ),
                        CustomListTile(
                          leading: IconlyLight.heart,
                          title: 'WishList',
                          onPressed: () {
                            navigate(context, const WishlistView());
                          },
                        ),
                        CustomListTile(
                          leading: IconlyLight.unlock,
                          title: 'forget password ',
                          onPressed: () {
                            navigate(context, const ForgetPasswordView());
                          },
                        ),
                        CustomListTile(
                          leading: IconlyLight.logout,
                          title: 'logout',
                          onPressed: () {
                            showSignOutDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }));
  }
}
