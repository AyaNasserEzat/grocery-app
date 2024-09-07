import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.leading,
    required this.title,
    this.subtitle,
    this.onPressed,
    super.key,
  });
  final IconData leading;
  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leading),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        subtitle ?? "",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
