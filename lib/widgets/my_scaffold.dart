import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/my_appbar.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key, required this.child, this.showAppbar, this.bottomNavigationBar});
  final Widget child;
  final bool? showAppbar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppbar ?? false ? const MyAppbar() : null,
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 100, 255),
              Color.fromARGB(255, 0, 0, 255),
              Color.fromARGB(255, 75, 10, 255),
              Color.fromARGB(255, 100, 20, 255),
              Color.fromARGB(255, 125, 40, 255),
            ],
          ),
        ),
        child: SafeArea(child: child),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
