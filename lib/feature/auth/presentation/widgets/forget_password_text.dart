import 'package:flutter/material.dart';

import 'package:grocery_app/feature/auth/presentation/view/forget_password_view.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ForgetPasswordView();
            }));
          },
          child: const Text(
            'Forget Password?',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                decorationColor: Colors.blue,
                decoration: TextDecoration.underline,
                color: Colors.blue,
                fontSize: 20),
          ),
        ),
      ],
    );
  }
}
