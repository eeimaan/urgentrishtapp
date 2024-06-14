import 'dart:io';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/auth.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class VerifyEmailScreen extends StatefulWidget {
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
  const VerifyEmailScreen(
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
      required this.paymentStatus,
      required this.cnicAddress,
      required this.motherAlive,
      required this.fatherAlive,
      required this.jointFamily});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  TextEditingController codeOtpController = TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  void initState() {
    super.initState();
    _initializeWidget();
  }

  Future<void> _initializeWidget() async {
    myauth.setTheme(theme: "v1");
    await myauth.setConfig(
      appEmail: "support@urgentrishtapp.com",
      appName: " Rishta registry",
       userEmail: 'adiyanyaqoob9773@gmail.com',
     // userEmail: widget.email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );

    if (await myauth.sendOTP()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP has been sent"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops, OTP send failed"),
        ),
      );
    }
  }

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: Image.asset(
                ImageConstants.emailImage,
                width: 400,
                height: 180,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              TextConstants.mailCheck,
              style: TextStyle(
                  fontSize: FontConstants.xlarge, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              TextConstants.verifyDetail,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontConstants.medium, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: FontConstants.medium, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              controller: codeOtpController,
              fillColor: Colors.white,
              keyboardType: TextInputType.number,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: ColorConstants.red, width: 2),
              ),
              hintText: '',
              obscureText: false,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              TextConstants.notReceive,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontConstants.medium, fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () async {
                myauth.setTheme(theme: "v1");
                myauth.setConfig(
                    appEmail: "support@urgentrishtapp.com",
                    appName: " Rishta registry",
                    userEmail: widget.email,
                    otpLength: 6,
                    otpType: OTPType.digitsOnly);
                if (await myauth.sendOTP() == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP has been sent"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Oops, OTP send failed"),
                  ));
                }
              },
              child: const Text(
                TextConstants.resent,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FontConstants.medium,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                onPressed: () async {
                  if (await myauth.verifyOTP(otp: codeOtpController.text) ==
                      true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("OTP is verified"),
                    ));
                    DbAuthService.signUp(
                      email: widget.email,
                      password: widget.password,
                      name: widget.name,
                      fatherName: widget.fatherName,
                      motherName: widget.motherName,
                      phoneNo: widget.phone,
                      cnic: widget.cnic,
                      home: widget.home,
                      address: widget.currentAddress,
                      gender: widget.gender,
                      cast: widget.cast,
                      religion: widget.religion,
                      sect: widget.sect,
                      maritalStatus: widget.maritalStatus,
                      job: widget.job,
                      qualification: widget.qualification,
                      height: widget.height,
                      weight: widget.weight,
                      age: widget.age,
                      city: widget.city,
                      province: widget.province,
                      smoking: widget.smoking,
                      disability: widget.disability,
                      skinColor: widget.skinColor,
                      brother: widget.brother,
                      sister: widget.sister,
                      bio: widget.bio,
                      interest: widget.interest,
                      dateOfBirth: widget.dateOfBirth,
                      partnerPref: widget.partnerPref,
                      image: widget.image,
                      frontCnic: widget.imageFrontCnic,
                      backCnic: widget.imageBackCnic,
                      imageSelfie: widget.imageSelfie,
                      paymentStatus: widget.paymentStatus,
                      verifyByAdminStatus: 'no',
                      cnicAddress: widget.cnicAddress,
                      motherAlive: widget.motherAlive,
                      fatherAlive: widget.fatherAlive,
                      jointFamily: widget.jointFamily,
                      role: 'user',
                      context: context,
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.pendingStatus, (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid OTP"),
                    ));
                  }
                },
                text: TextConstants.verify,
                width: 350,
                btnColor: ColorConstants.red,
                textColor: Colors.white),
          ]),
        ),
      ),
    );
  }
}

class CustomVerifyContainer extends StatelessWidget {
  final String number;

  const CustomVerifyContainer({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorConstants.red, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: FontConstants.medium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
//  if (await myauth.verifyOTP(otp: codeOtpController.text) == true) {
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           content: Text("OTP is verified"),
//                         ));
//                       } else {
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           content: Text("Invalid OTP"),
//                         ));
//                       }