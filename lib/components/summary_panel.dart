import 'package:flutter/material.dart';

class SummaryPanel extends StatelessWidget {
  final Widget widget;
  const SummaryPanel({
    required this.widget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        const Expanded(child: Divider()),
        const SizedBox(width: 10),
        widget,
        const SizedBox(width: 10),
        const Expanded(child: Divider()),
        const SizedBox(width: 20),
      ],
    );
  }
}
