import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/providers/providers.dart';
import 'package:urgentrishtapp/screens/screens.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
     
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          TextConstants.forgotpsd,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.large, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Text(
              TextConstants.createPsd,
              style: TextStyle(
                  fontSize: FontConstants.xlarge, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<PasswordIconToggleProvider>(
              builder: (context, value, child) => TextFieldWidget(
                // validator: (input) {
                //   if (input == null || input.isEmpty) {
                //     return 'Please enter a password';
                //   } else if (input.length < 6) {
                //     return 'Password must be at least 6 characters long';
                //   }
                //   return null;
                // },
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
          
                obscureText: !value.isNewVisible, // Adjusted this line
                // controller: passwordController,
                hintText: 'New password',
                suffixIcon: InkWell(
                  onTap: () {
                    Provider.of<PasswordIconToggleProvider>(context,
                            listen: false)
                        .toggleNewVisibility(); // Adjusted this line
                  },
                  child: Icon(
                    value.isNewVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<PasswordIconToggleProvider>(
              builder: (context, value, child) => TextFieldWidget(
                // validator: (input) {
                //   if (input == null || input.isEmpty) {
                //     return 'Please enter a password';
                //   } else if (input.length < 6) {
                //     return 'Password must be at least 6 characters long';
                //   }
                //   return null;
                // },
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
          
                obscureText: !value.isVisible, // Adjusted this line
                // controller: passwordController,
                hintText: 'Confirm password',
                suffixIcon: InkWell(
                  onTap: () {
                    Provider.of<PasswordIconToggleProvider>(context,
                            listen: false)
                        .toggleVisibility(); // Adjusted this line
                  },
                  child: Icon(
                    value.isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                CustomCheckBox(
                  borderColor: ColorConstants.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  TextConstants.remenberPsd,
                  style: TextStyle(
                    fontSize: FontConstants.small,
                    color: ColorConstants.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 120,
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                '2 of 2',
                style: TextStyle(
                    fontSize: FontConstants.medium, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: HalfColoredProgressBar(progress: 1),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: ButtonWidget(
                    onPressed: () {},
                    text: TextConstants.resetPsd,
                    width: 350,
                    btnColor: ColorConstants.orange,
                    textColor: Colors.black)),
          ]),
        ),
      ),
    );
  }
}
