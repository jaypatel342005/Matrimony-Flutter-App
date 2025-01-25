import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/widgets/app_bar.dart';
import 'package:matrimony_flutter_app/widgets/drawer.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Add Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
