import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class GradientBtn extends StatelessWidget {
  const GradientBtn({super.key, this.onTap, this.width, required this.child});
  final void Function()? onTap;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 1)],
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
            Color.fromARGB(255, 40, 78, 184),
            Color.fromARGB(255, 64, 67, 233),
            Color.fromARGB(255, 33, 130, 242),
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
