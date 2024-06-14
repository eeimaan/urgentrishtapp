import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateBasedOnAuthState();
  }

  void navigateBasedOnAuthState() {
    var user = FirebaseAuth.instance.currentUser;
    Timer(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          if (user == null) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRoutes.pendingStatus);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                child: Image.asset(
                  ImageConstants.logoImage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
