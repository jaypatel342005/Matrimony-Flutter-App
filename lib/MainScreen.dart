import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/widgets/Dashboard_Screen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    final appBarColor = Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).primaryColor;

    return Container(
      color: appBarColor, // Match SafeArea color to AppBar color
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Main Screen'),
        ),
        body: Dashboard()
      ),
    );
  }
}
