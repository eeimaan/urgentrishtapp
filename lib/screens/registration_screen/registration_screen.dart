import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/providers/providers.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: "John Doe");
    final TextEditingController fatherNameController =
        TextEditingController(text: "Richard Doe");
    final TextEditingController motherNameController =
        TextEditingController(text: "Jane Doe");
    final TextEditingController emailController =
        TextEditingController(text: "");
    final TextEditingController passwordController =
        TextEditingController(text: "password123");
    final TextEditingController confirmPasswordController =
        TextEditingController(text: "password123");
    final TextEditingController phoneController =
        TextEditingController(text: "+923001234567");
    final TextEditingController cnicController =
        TextEditingController(text: "5210291324604");
    final TextEditingController currentAddressController =
        TextEditingController(text: "123 Main St, Anytown, USA");
         final TextEditingController cnicAddressController =
        TextEditingController(text: "123 Main St, Anytown, USA");

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          TextConstants.registration,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Name',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '',
                obscureText: false,
                controller: nameController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter name';
                  } else if (!isValidName(input)) {
                    return 'Please enter valid name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Father Name',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '',
                obscureText: false,
                controller: fatherNameController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter father name';
                  } else if (!isValidName(input)) {
                    return 'Please enter valid name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Mother Name',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '',
                obscureText: false,
                controller: motherNameController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter mother name';
                  } else if (!isValidName(input)) {
                    return 'Please enter valid name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Email',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '',
                obscureText: false,
                controller: emailController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter email';
                  } else if (!isValidEmail(input)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
                prefixIcon:
                    const Icon(Icons.person_2_outlined, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Password',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              Consumer<PasswordIconToggleProvider>(
                builder: (context, value, child) => TextFieldWidget(
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter password';
                    } else if (input.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.black),
                  obscureText: !value.isNewVisible,
                  controller: passwordController,
                  hintText: '',
                  suffixIcon: InkWell(
                    onTap: () {
                      Provider.of<PasswordIconToggleProvider>(context,
                              listen: false)
                          .toggleNewVisibility();
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
              const Text(
                'Confirm Password',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              Consumer<PasswordIconToggleProvider>(
                builder: (context, value, child) => TextFieldWidget(
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter confirm password';
                    } else if (input.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.black),
                  obscureText: !value.isVisible,
                  controller: confirmPasswordController,
                  hintText: '',
                  suffixIcon: InkWell(
                    onTap: () {
                      Provider.of<PasswordIconToggleProvider>(context,
                              listen: false)
                          .toggleVisibility();
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
                height: 10,
              ),
              const Text(
                'Mobile number',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                hintText: '',
                obscureText: false,
                controller: phoneController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter number';
                  } else if (!isValidPakistaniNumber(input)) {
                    return 'Please enter valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Cnic',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '',
                obscureText: false,
                controller: cnicController,
                keyboardType: TextInputType.number,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter cnic';
                  } else if (!isValidCNIC(input)) {
                    return 'Please enter valid cnic';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Current address ',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '',
                obscureText: false,
                controller: currentAddressController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter address';
                  } else if (!isValidAddress(input)) {
                    return 'Please enter valid address';
                  }
                  return null;
                },
              ), const SizedBox(
                height: 10,
              ),
              const Text(
                'Cnic address ',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '',
                obscureText: false,
                controller: cnicAddressController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter address';
                  } else if (!isValidAddress(input)) {
                    return 'Please enter valid address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: ButtonWidget(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Navigator.of(context).pushNamed(
                            AppRoutes.basicInfo,
                            arguments: {
                              'email': emailController.text,
                              'password': passwordController.text,
                              'name': nameController.text,
                              'fatherName': fatherNameController.text,
                              'motherName': motherNameController.text,
                              'phoneNo': phoneController.text,
                              'cnic': cnicController.text,
                              'address': currentAddressController.text,
                              'cnicAddress':cnicAddressController.text,
                            },
                          );
                        }
                      },
                      text: TextConstants.next,
                      width: 350,
                      btnColor:  ColorConstants.orange,
                      textColor: Colors.black)),
              const SizedBox(
                height: 30,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// class ScanContainer extends StatelessWidget {
//   final void Function()? onPressed;

//   const ScanContainer({
//     super.key,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: 80,
//         height: 35,
//         decoration: BoxDecoration(
//           color: ColorConstants.orange,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const Padding(
//           padding: EdgeInsets.all(5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.document_scanner_outlined,
//                 size: FontConstants.exsmall,
//               ),
//               SizedBox(
//                 width: 5,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Scan',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: FontConstants.exsmall,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//  Container(
//                 decoration: BoxDecoration(
//                   color: ColorConstants.yellow,
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

//                   //  initialCountryCode: '+92',
//                   // showCountryFlag: false,

//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: ColorConstants.yellow,
//                     hintText: 'Phone number',
//                     hintStyle: const TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.w300),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 10),
//                     border: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: ColorConstants.yellow),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: ColorConstants.yellow),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: ColorConstants.yellow),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: ColorConstants.yellow),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(color: ColorConstants.yellow),
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
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (input) {
//                     if (input == null || input.number.isEmpty) {
//                       return 'Please enter a phone number';
//                     } else if (!isValidNumber(input.completeNumber)) {
//                       return 'Invalid phone number';
//                     }
//                     return null;
//                   },
//                 ),
//               ),