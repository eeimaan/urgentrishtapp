import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/utils/utils.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class VerifyDocuments extends StatefulWidget {
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

  final String cnicAddress;
  final String motherAlive;
  final String fatherAlive;
  final String jointFamily;
  const VerifyDocuments(
      {Key? key,
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
      required this.cnicAddress,
      required this.motherAlive,
      required this.fatherAlive,
      required this.jointFamily})
      : super(key: key);

  @override
  State<VerifyDocuments> createState() => _VerifyDocumentsState();
}

class _VerifyDocumentsState extends State<VerifyDocuments> {
  final ValueNotifier<File?> _imageFrontCnicNotifier =
      ValueNotifier<File?>(null);
  final ValueNotifier<File?> _imageBackCnicNotifier =
      ValueNotifier<File?>(null);
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<String> _resultNotifier = ValueNotifier<String>('');

  late File? imageFrontCnic;
  late File? imageBackCnic;
  late File? imageSelfie;

  @override
  void dispose() {
    _imageFrontCnicNotifier.dispose();
    _imageBackCnicNotifier.dispose();
    _imageNotifier.dispose();
    _resultNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'Scan',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Please scan both side of your CNIC and your face for identity verification.',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Scan CNIC',
                    style: TextStyle(
                        fontSize: FontConstants.medium,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        imageFrontCnic = await AppUtils.captureImage();
                        if (imageFrontCnic != null) {
                          _imageFrontCnicNotifier.value = imageFrontCnic;
                        }
                      },
                      child: ValueListenableBuilder<File?>(
                          valueListenable: _imageFrontCnicNotifier,
                          builder: (context, file, child) {
                            return Container(
                                width: 150,
                                height: 200,
                                decoration: file == null
                                    ? BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    : const BoxDecoration(),
                                child: file == null
                                    ? const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_alt),
                                          Text(
                                            'Front Image',
                                            style: TextStyle(
                                              fontSize: FontConstants.exsmall,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Image.file(file));
                          }),
                    ),
                    GestureDetector(
                      onTap: () async {
                        imageBackCnic = await AppUtils.captureImage();
                        if (imageBackCnic != null) {
                          _imageBackCnicNotifier.value = imageBackCnic;
                        }
                      },
                      child: ValueListenableBuilder<File?>(
                          valueListenable: _imageBackCnicNotifier,
                          builder: (context, file, child) {
                            return Container(
                                width: 150,
                                height: 200,
                                decoration: file == null
                                    ? BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    : const BoxDecoration(),
                                child: file == null
                                    ? const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_alt),
                                          Text(
                                            'Back Image',
                                            style: TextStyle(
                                              fontSize: FontConstants.exsmall,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Image.file(file));
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Take a selfie',
                    style: TextStyle(
                        fontSize: FontConstants.medium,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    imageSelfie = await AppUtils.captureImage();
                    if (imageSelfie != null) {
                      _imageNotifier.value = imageSelfie;
                    }
                  },
                  child: ValueListenableBuilder<File?>(
                      valueListenable: _imageNotifier,
                      builder: (context, file, child) {
                        return Container(
                            width: 150,
                            height: 200,
                            decoration: file == null
                                ? BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                  )
                                : const BoxDecoration(),
                            child: file == null
                                ? const Icon(Icons.camera_alt)
                                : Image.file(file));
                      }),
                ),
                const SizedBox(height: 20),
                // ValueListenableBuilder<String>(
                //   valueListenable: _resultNotifier,
                //   builder: (context, result, child) {
                //     return result == 'Identity verified successfully'
                //         ? const SizedBox.shrink()
                //         : ButtonWidget(
                //             onPressed: () {
                //               IdentityVerifier().verifyIdentity(
                //                 imageFrontCnic: _imageFrontCnicNotifier.value,
                //                 imageBackCnic: _imageBackCnicNotifier.value,
                //                 imageSelfie: _imageNotifier.value,
                //                 setResult: (String newResult) {
                //                   _resultNotifier.value = newResult;
                //                 },
                //               );
                //               log('button tap');
                //             },
                //             text: 'Verify Identity',
                //             width: 150,
                //             btnColor: ColorConstants.orange,
                //             textColor: Colors.black);
                //   },
                // ),
                const SizedBox(height: 20),
                ValueListenableBuilder<String>(
                  valueListenable: _resultNotifier,
                  builder: (context, result, child) {
                    return Text(
                      result,
                      style: const TextStyle(
                          fontSize: FontConstants.large,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.payment, arguments: {
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
                        'frontCnic': imageFrontCnic,
                        'backCnic': imageBackCnic,
                        'imageSelfie': imageSelfie,
                        'cnicAddress': widget.cnicAddress,
                        'motherAlive': widget.motherAlive,
                        'fatherAlive': widget.fatherAlive,
                        'jointFamily': widget.jointFamily,
                      });
                    },
                    text: 'Next',
                    width: 350,
                    btnColor:  ColorConstants.orange,
                    textColor: Colors.black),
                // ValueListenableBuilder<String>(
                //   valueListenable: _resultNotifier,
                //   builder: (context, result, child) {
                //     return result == 'Identity verified successfully'
                //         ? ButtonWidget(
                //             onPressed: () {
                //               if (_imageNotifier.value != null &&
                //                   _imageBackCnicNotifier.value != null &&
                //                   _imageFrontCnicNotifier.value != null) {
                //                 Navigator.of(context)
                //                     .pushNamed(AppRoutes.payment, arguments: {
                //                   'email': widget.email,
                //                   'name': widget.name,
                //                   'fatherName': widget.fatherName,
                //                   'motherName': widget.motherName,
                //                   'phoneNo': widget.phone,
                //                   'password': widget.password,
                //                   'cnic': widget.cnic,
                //                   'address': widget.currentAddress,
                //                   'gender': widget.gender,
                //                   'cast': widget.cast,
                //                   'religion': widget.religion,
                //                   'sect': widget.sect,
                //                   'maritalStatus': widget.maritalStatus,
                //                   'job': widget.job,
                //                   'home': widget.home,
                //                   'kids': widget.kids,
                //                   'qualification': widget.qualification,
                //                   'height': widget.height,
                //                   'weight': widget.weight,
                //                   'age': widget.age,
                //                   "city": widget.city,
                //                   "province": widget.province,
                //                   "smoking": widget.smoking,
                //                   'disability': widget.disability,
                //                   'skinColor': widget.skinColor,
                //                   'brother': widget.brother,
                //                   'sister': widget.sister,
                //                   'bio': widget.bio,
                //                   'interest': widget.interest,
                //                   'dateOfBirth': widget.dateOfBirth,
                //                   'partnerPref': widget.partnerPref,
                //                   'image': widget.image,
                //                   'frontCnic': imageFrontCnic,
                //                   'backCnic': imageBackCnic,
                //                   'imageSelfie': imageSelfie,
                //                   'cnicAddress': widget.cnicAddress,
                //                   'motherAlive': widget.motherAlive,
                //                   'fatherAlive': widget.fatherAlive,
                //                   'jointFamily': widget.jointFamily,
                //                 });
                //               } else {
                //                 ScaffoldMessenger.of(context).showSnackBar(
                //                   const SnackBar(
                //                     content: Text(
                //                         'Please upload picture and verify'),
                //                     backgroundColor: Colors.red,
                //                   ),
                //                 );
                //               }
                //             },
                //             text: 'Next',
                //             width: 350,
                //             btnColor:  ColorConstants.orange,
                //             textColor: Colors.black)
                //         : const SizedBox.shrink();
                //   },
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
