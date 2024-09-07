import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/feature/auth/presentation/view/login_view.dart';
import 'package:grocery_app/feature/home/presentation/view/bottomVavigtion.dart';

class SplahView extends StatefulWidget {
  const SplahView({super.key});

  @override
  State<SplahView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplahView> {
  get cont => null;

  @override
  void initState() {
    
    FirebaseAuth.instance.currentUser != null
        ? Future.delayed(
            const Duration(seconds: 3),
            () {
              navigate(context, const BottomvavigtionView());
            },
          )
        : Future.delayed(const Duration(seconds: 3),() {navigate(context, const LoginView());} ,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00784a),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logoo.jpeg'),
          ],
        ),
      ),
    );
  }
}
