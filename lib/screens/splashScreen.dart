// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:disease_pred/screens/authScreen.dart';
import 'package:disease_pred/tabManager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final bool isAuth; // false if not logged in.

  const SplashScreen({
    Key? key,
    required this.isAuth,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => widget.isAuth ? const TabManager() : const AuthScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/OnBoardsq.jpg',
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Qure.io',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
