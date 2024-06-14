import 'dart:io';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/widgets/check_box_widget.dart';

class TermsAgreeScreen extends StatefulWidget {
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
  final String paymentStatus;
  final String cnicAddress;
  final String motherAlive;
  final String fatherAlive;
  final String jointFamily;
  const TermsAgreeScreen(
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
      required this.city,
      required this.province,
      required this.smoking,
      required this.disability,
      required this.skinColor,
      required this.brother,
      required this.sister,
      required this.home,
      required this.bio,
      required this.interest,
      required this.partnerPref,
      required this.dateOfBirth,
      required this.image,
      required this.imageFrontCnic,
      required this.imageBackCnic,
      required this.imageSelfie,
      required this.paymentStatus,
      required this.cnicAddress,
      required this.motherAlive,
      required this.fatherAlive,
      required this.jointFamily});

  @override
  State<TermsAgreeScreen> createState() => _TermsAgreeScreenState();
}

class _TermsAgreeScreenState extends State<TermsAgreeScreen> {
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
          TextConstants.termTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge,
              fontWeight: FontWeight.w500,
              color: ColorConstants.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              TextConstants.termsHeading,
              style: TextStyle(
                  fontSize: FontConstants.small, color: ColorConstants.red),
            ),
            const Text(
              TextConstants.termsAggrement,
              style: TextStyle(
                fontSize: FontConstants.small,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              TextConstants.termHeadingUrdu,
              style: TextStyle(
                  fontSize: FontConstants.small, color: ColorConstants.red),
            ),
            const Text(
              TextConstants.termAgreementUrdu,
              style: TextStyle(
                fontSize: FontConstants.small,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Row(
              children: [
                CustomCheckBox(
                  borderColor: ColorConstants.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    TextConstants.acceptTerms,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontConstants.exsmall,
                      color: ColorConstants.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          surfaceTintColor: Colors.white,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20.0),
                                  const Text(
                                    'To create an account you have to agree with terms and conditions',
                                    style: TextStyle(
                                      fontSize: FontConstants.medium,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20.0),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 80,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: ColorConstants.red,
                                            width: 2),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: FontConstants.exsmall,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: ColorConstants.red, width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        TextConstants.notAcceptAgree,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontConstants.exsmall,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.verifyEmail, arguments: {
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
                      'paymentStatus': widget.paymentStatus,
                      'cnicAddress': widget.cnicAddress,
                      'motherAlive': widget.motherAlive,
                      'fatherAlive': widget.fatherAlive,
                      'jointFamily': widget.jointFamily,
                    });
                  },
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        TextConstants.acceptAgree,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontConstants.exsmall,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}

//  myauth.setConfig(
//                         appEmail: "me@rohitchouhan.com",
//                         appName: "Email OTP",
//                         userEmail: widget.email,
//                         otpLength: 6,
//                         otpType: OTPType.digitsOnly);
//                     if (await myauth.sendOTP() == true) {
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                         content: Text("OTP has been sent"),
//                       ));
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                         content: Text("Oops, OTP send failed"),
//                       ));
//                     }
// final Email email = Email(
                    //   body: 'hey',
                    //   subject: 'send',
                    //   recipients: [widget.email],
                    // );
 // try {
                    //   await FlutterEmailSender.send(email);
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text('Email sent successfully'),
                    //     ),
                    //   );
                    // } catch (error) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text('Failed to send email: $error'),
                    //     ),
                    //   );
                    // }