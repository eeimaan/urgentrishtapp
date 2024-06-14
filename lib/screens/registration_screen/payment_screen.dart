import 'dart:io';

import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class PaymentScreen extends StatefulWidget {
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
  const PaymentScreen(
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
      required this.imageSelfie, required this.cnicAddress, required this.motherAlive, required this.fatherAlive, required this.jointFamily});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
          'Payment',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            const Text(
              TextConstants.paymentDetails,
              style: TextStyle(
                fontSize: FontConstants.medium,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Basic Plan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: FontConstants.medium,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "\$10 per month \nIncludes access to all features.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: FontConstants.medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Center(
                child: ButtonWidget(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.paymentMethod, arguments: {
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
                          'cnicAddress': widget.cnicAddress,
                                    'motherAlive': widget.motherAlive,
                                    'fatherAlive': widget.fatherAlive,
                                    'jointFamily': widget.jointFamily,
                      });
                    },
                    text: 'Select payment method',
                    width: 350,
                    btnColor: ColorConstants.orange,
                    textColor: Colors.black)),
          ]),
        ),
      ),
    );
  }
}
