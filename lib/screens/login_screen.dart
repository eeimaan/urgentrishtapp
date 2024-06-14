import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/auth.dart';
import 'package:urgentrishtapp/providers/providers.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    ImageConstants.logoImage,
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      TextConstants.login,
                      style: TextStyle(
                          fontSize: FontConstants.xxlarge,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      ImageConstants.waveImage,
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
                const Text(
                  TextConstants.loginDetail,
                  style: TextStyle(fontSize: FontConstants.medium),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  hintText: TextConstants.email,
                  obscureText: false,
                  controller: emailController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  prefixIcon:
                      const Icon(Icons.person_2_outlined, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<PasswordIconToggleProvider>(
                  builder: (context, value, child) => TextFieldWidget(
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter a password';
                      } else if (input.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.black),

                    obscureText: !value.isVisible, // Adjusted this line
                    controller: passwordController,
                    hintText: 'Password',
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                    },
                    child: const Text(
                      TextConstants.forgotpsd,
                      style: TextStyle(
                          fontSize: FontConstants.exsmall,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Center(
                    child: ButtonWidget(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            DbAuthService.signIn(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        text: TextConstants.signin,
                        width: 250,
                        btnColor: ColorConstants.orange,
                        textColor: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.register);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        TextConstants.dontHaveAccount,
                        style: TextStyle(
                            fontSize: FontConstants.small,
                            color: ColorConstants.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        TextConstants.register,
                        style: TextStyle(
                          fontSize: FontConstants.small,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// const Center(
//                 child: Text(
//                   TextConstants.loginbyNo,
//                   style: TextStyle(
//                       fontSize: FontConstants.medium,
//                       color: ColorConstants.grey),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 0,
//                       blurRadius: 3,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IntlPhoneField(
//                   disableLengthCheck: true,
//                   pickerDialogStyle:
//                       PickerDialogStyle(backgroundColor: ColorConstants.yellow),
//                   controller: phoneController,
//                   keyboardType: TextInputType.phone,
//                   focusNode: focusNode,
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: ColorConstants.yellow,
//                     hintText: 'Phone number',
//                     hintStyle: const TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.w300),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 10),
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.transparent),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.transparent),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.transparent),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   languageCode: "en",
//                   onChanged: (phone) {
//                     // log(phone.completeNumber);
//                   },
//                   onCountryChanged: (country) {},
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   validator: (PhoneNumber? input) {
//                     if (input == null || input.number.isEmpty) {
//                       return 'Please enter a phone number';
//                     } else if (!isValidNumber(input.completeNumber)) {
//                       return 'Invalid phone number';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),