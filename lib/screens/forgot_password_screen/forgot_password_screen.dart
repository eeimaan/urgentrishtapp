import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/auth.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                TextConstants.forgotpsd,
                style: TextStyle(
                    fontSize: FontConstants.xlarge,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: Image.asset(
                  ImageConstants.passwordImage,
                  width: 400,
                  height: 280,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                TextConstants.forgotdetail,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FontConstants.medium,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                hintText: TextConstants.email,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 0.3),
                ),
                controller: emailController,
                prefixIcon: const Icon(Icons.mail, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: ButtonWidget(
                      onPressed: () {
                        DbAuthService.resetPassword(
                            emailController.text, context);
                      },
                      text: 'send',
                      width: 350,
                      btnColor: ColorConstants.orange,
                      textColor: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
