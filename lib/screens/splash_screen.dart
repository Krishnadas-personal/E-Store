import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/category_provider.dart';
import 'category_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool _init = true;
  bool _isLoading = true;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CategoryList())));
    super.initState();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FadeTransition(
            opacity: animation,
            child: Image.asset(
              'assets/splash_img.png',
              height: 500.0,
              width: 500.0,
              fit: BoxFit.fitWidth,
            ),
          ),
          if (_isLoading) const CircularProgressIndicator()
        ],
      ),
    );
  }
}
