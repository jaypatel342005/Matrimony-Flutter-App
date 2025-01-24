import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/bottom_nav_bar.dart';
import 'package:matrimony_flutter_app/custom_app_bar.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBarWidget(),
      ),
    );
  }
}
