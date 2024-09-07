import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    required this.itemBuilder,
    required this.itemCount,
    super.key,
  });
  final Widget? Function(BuildContext context, int indx) itemBuilder;
  final int? itemCount;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 150 / 190,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
