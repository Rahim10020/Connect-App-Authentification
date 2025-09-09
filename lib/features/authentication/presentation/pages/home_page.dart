import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print('🏠 HomePage initialisée');
  }

  @override
  Widget build(BuildContext context) {
    print('🏠 HomePage en cours de construction');
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("Home")),
    );
  }
}
