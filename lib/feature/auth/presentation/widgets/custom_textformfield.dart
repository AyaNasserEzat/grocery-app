import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    required this.hintText,
    this.isPassword=false,
    this.suffixIcon,
    this.onChange,
    this.controller,
    super.key,
  });
  String? hintText;
  Widget? suffixIcon;
  bool? isPassword;
  TextEditingController? controller;
  Function(String)? onChange;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword == true ? obscureText : false,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword == true
             ?
          
             IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: obscureText == true
                    ? const Icon(
                        Icons.visibility_off,
                      )
                    : const Icon(
                        Icons.visibility,
                      ),
                      color: Colors.white
              )
            : widget.suffixIcon,
        hintStyle: const TextStyle(color: Colors.white),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
