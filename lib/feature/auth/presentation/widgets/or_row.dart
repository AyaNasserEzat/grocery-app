import 'package:flutter/material.dart';

class ORRow extends StatelessWidget {
  const ORRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Flexible(
            child: Divider(
          thickness: 2,
        )),
        SizedBox(
          width: 7,
        ),
        Text(
          'OR ',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Flexible(
            child: Divider(
          thickness: 2,
        )),
      ],
    );
  }
}
