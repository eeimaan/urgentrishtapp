import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';

class PendingVerificationScreen extends StatefulWidget {
  const PendingVerificationScreen({super.key});

  @override
  State<PendingVerificationScreen> createState() =>
      _PendingVerificationScreenState();
}

class _PendingVerificationScreenState extends State<PendingVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Please wait",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FontConstants.xlarge,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Your account is currently undergoing verification. Please allow up to 24 hours for this process to be completed. We'll notify you as soon as your account is verified and ready for use. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FontConstants.medium,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "Thank you for your patience!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FontConstants.medium,
                    fontWeight: FontWeight.bold),
              ),
            ]),
      ),
    );
  }
}
