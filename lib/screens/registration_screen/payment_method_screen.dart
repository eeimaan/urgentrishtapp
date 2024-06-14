import 'dart:io';

import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/screens/screens.dart';
import 'package:urgentrishtapp/utils/app_utils.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class PaymentMetodScreen extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String fatherName;
  final String motherName;
  final String phone;
  final String cnic;
  final String currentAddress;
  final String gender;
  final String cast;
  final String religion;
  final String sect;
  final String maritalStatus;
  final String job;
  final String? kids;
  final String qualification;
  final String height;
  final String weight;
  final String age;
  final String home;
  final String city;
  final String province;
  final String smoking;
  final String disability;
  final String skinColor;
  final String brother;
  final String sister;
  final String bio;
  final String interest;
  final String partnerPref;
  final String dateOfBirth;
  final File image;
  final File imageFrontCnic;
  final File imageBackCnic;
  final File imageSelfie;

  final String cnicAddress;
  final String motherAlive;
  final String fatherAlive;
  final String jointFamily;
  const PaymentMetodScreen(
      {super.key,
      required this.email,
      required this.password,
      required this.name,
      required this.fatherName,
      required this.motherName,
      required this.phone,
      required this.cnic,
      required this.currentAddress,
      required this.gender,
      required this.cast,
      required this.religion,
      required this.sect,
      required this.maritalStatus,
      required this.job,
      this.kids,
      required this.qualification,
      required this.height,
      required this.weight,
      required this.age,
      required this.home,
      required this.city,
      required this.province,
      required this.smoking,
      required this.disability,
      required this.skinColor,
      required this.brother,
      required this.sister,
      required this.bio,
      required this.interest,
      required this.partnerPref,
      required this.dateOfBirth,
      required this.image,
      required this.imageFrontCnic,
      required this.imageBackCnic,
      required this.imageSelfie,
      required this.cnicAddress,
      required this.motherAlive,
      required this.fatherAlive,
      required this.jointFamily});

  @override
  State<PaymentMetodScreen> createState() => _PaymentMetodScreenState();
}

class _PaymentMetodScreenState extends State<PaymentMetodScreen> {
  TextEditingController nameCardController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController securityCodeController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
          'Payment Method',
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
                'Pay by Card',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FontConstants.xlarge,
                ),
              ),
              const Text(
                'Card number',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '1234 4567 6789',
                obscureText: false,
                fillColor: Colors.white,
                keyboardType: TextInputType.number,
                controller: cardNumberController,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Expire Date',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: 'mm/yy',
                obscureText: false,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                controller: expiryDateController,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Security code',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: '*******',
                obscureText: false,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                controller: securityCodeController,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Card Holder',
                style: TextStyle(fontSize: FontConstants.large),
              ),
              TextFieldWidget(
                hintText: 'Enter card holder name',
                obscureText: false,
                fillColor: Colors.white,
                keyboardType: TextInputType.name,
                controller: nameCardController,
              ),
              const SizedBox(
                height: 30,
              ),
              const CustomTextContainer(
                text: 'Contact us ',
                heading: 'Pay by Whatsapp',
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: ButtonWidget(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                            ),
                            child: BottomSheetPaymentWidget(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.termsAgree,
                                    arguments: {
                                      'email': widget.email,
                                      'name': widget.name,
                                      'fatherName': widget.fatherName,
                                      'motherName': widget.motherName,
                                      'phoneNo': widget.phone,
                                      'password': widget.password,
                                      'cnic': widget.cnic,
                                      'address': widget.currentAddress,
                                      'gender': widget.gender,
                                      'cast': widget.cast,
                                      'religion': widget.religion,
                                      'sect': widget.sect,
                                      'maritalStatus': widget.maritalStatus,
                                      'job': widget.job,
                                      'home': widget.home,
                                      'kids': widget.kids,
                                      'qualification': widget.qualification,
                                      'height': widget.height,
                                      'weight': widget.weight,
                                      'age': widget.age,
                                      "city": widget.city,
                                      "province": widget.province,
                                      "smoking": widget.smoking,
                                      'disability': widget.disability,
                                      'skinColor': widget.skinColor,
                                      'brother': widget.brother,
                                      'sister': widget.sister,
                                      'bio': widget.bio,
                                      'interest': widget.interest,
                                      'dateOfBirth': widget.dateOfBirth,
                                      'partnerPref': widget.partnerPref,
                                      'image': widget.image,
                                      'frontCnic': widget.imageFrontCnic,
                                      'backCnic': widget.imageBackCnic,
                                      'imageSelfie': widget.imageSelfie,
                                      'paymentStatus': 'yes',
                                      'cnicAddress': widget.cnicAddress,
                                      'motherAlive': widget.motherAlive,
                                      'fatherAlive': widget.fatherAlive,
                                      'jointFamily': widget.jointFamily,
                                    });
                              },
                            ),
                          );
                        },
                      );
                        }
                      },
                      text: 'Confirm',
                      width: 350,
                      btnColor: ColorConstants.orange,
                      textColor: Colors.black)),
            ]),
          ),
        ),
      ),
    );
  }
}
