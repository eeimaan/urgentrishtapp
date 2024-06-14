import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urgentrishtapp/constants/constants.dart';

class PendingStatusScreen extends StatefulWidget {
  const PendingStatusScreen({super.key});

  @override
  State<PendingStatusScreen> createState() => _PendingStatusScreenState();
}

class _PendingStatusScreenState extends State<PendingStatusScreen> {
  bool _verified = false;

  @override
  void initState() {
    super.initState();
    navigateBasedOnVerify();
  }

  Future<void> navigateBasedOnVerify() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        log('..............uid ${user.uid}');
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists &&
            userData.data()!.containsKey('verify_by_admin_status')) {
          final verificationStatus = userData.data()!['verify_by_admin_status'];
          setState(() {
            _verified = verificationStatus == 'yes';
          });
          navigateAccordingly();
        } else {
          log('User data is missing or lacks verification field');
        }
      } else {
        log('No user is currently signed in');
      }
    } catch (error) {
      log('Error checking verification status: $error');
    }
  }

  void navigateAccordingly() {
    if (_verified) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.pendingVerify);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: _verified
              ? const Text('Your account has been verified. Welcome!')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Thank you for your patience!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Your account is currently undergoing verification. Please allow up to 24 hours for this process to be completed. We'll notify you as soon as your account is verified and ready for use. ",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
