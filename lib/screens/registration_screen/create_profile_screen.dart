import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/utils/utils.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class CreateProfileScreen extends StatefulWidget {
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

  final String cnicAddress;
  final String motherAlive;
  final String fatherAlive;
  final String jointFamily;
  const CreateProfileScreen(
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
      required this.cnicAddress,
      required this.motherAlive,
      required this.fatherAlive,
      required this.jointFamily})
      : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  late final File? image;
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController bioController =
        TextEditingController(text: "hey, there ");
    final TextEditingController interestController =
        TextEditingController(text: "football");
    final TextEditingController prefrencesController =
        TextEditingController(text: "Sindhi");

    DateTime dateOfBirth = DateTime.now();
    final ValueNotifier<DateTime> timeDateNotifier =
        ValueNotifier(DateTime.now());
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
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: Center(
                    child: Stack(
                      children: [
                        ValueListenableBuilder<File?>(
                          valueListenable: _imageNotifier,
                          builder: (context, file, child) {
                            return Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: file == null
                                  ? const Icon(
                                      Icons.person_outlined,
                                      color: ColorConstants.purple,
                                      size: 70,
                                    )
                                  : ClipOval(
                                      child: Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150,
                                      ),
                                    ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              image = await AppUtils.pickImage();

                              _imageNotifier.value = image;
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add,
                                color: ColorConstants.purple,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Bio',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  hintText: 'Enter a description...',
                  obscureText: false,
                  maxLines: 4,
                  controller: bioController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter bio';
                    }
                    return null;
                  },
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.3),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Interest',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  hintText: 'Enter interest',
                  obscureText: false,
                  controller: interestController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter details';
                    }
                    return null;
                  },
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.3),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Partner prefrences',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  hintText: 'Enter a partner prefrences',
                  obscureText: false,
                  controller: prefrencesController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter details';
                    }
                    return null;
                  },
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.3),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Date of Birth',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder<DateTime>(
                          valueListenable: timeDateNotifier,
                          builder: (context, selectedDate, _) {
                            dateOfBirth = selectedDate;
                            log('.........date $dateOfBirth');

                            return Text(
                              selectedDate.toLocal().toString().split(' ')[0],
                              style: const TextStyle(fontSize: 14),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            size: 20,
                          ),
                          color: Colors.black,
                          onPressed: () {
                            DateOfAge.openDatePicker(
                              context,
                              timeNotifier: timeDateNotifier,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: ButtonWidget(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (_imageNotifier.value != null) {
                              final ageLimitDate = DateTime.now()
                                  .subtract(const Duration(days: 18 * 365));
                              if (dateOfBirth.isBefore(ageLimitDate)) {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.verifyDocument,
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
                                      'bio': bioController.text,
                                      'interest': interestController.text,
                                      'dateOfBirth': dateOfBirth.toString(),
                                      'partnerPref': prefrencesController.text,
                                      'image': image,
                                      'cnicAddress': widget.cnicAddress,
                                      'motherAlive': widget.motherAlive,
                                      'fatherAlive': widget.fatherAlive,
                                      'jointFamily': widget.jointFamily,
                                    });
                              } else {
                                // Date is not valid
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'You must be 18 years old or older'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please upload profile picture'),
                                  backgroundColor:  Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        text: TextConstants.next,
                        width: 350,
                        btnColor: ColorConstants.orange,
                        textColor: Colors.black)),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//  log('email: ${widget.email}');
//                         log('name: ${widget.name}');
//                         log('fatherName: ${widget.fatherName}');
//                         log('motherName: ${widget.motherName}');
//                         log('phoneNo: ${widget.phone}');
//                         log('password: ${widget.password}');
//                         log('cnic: ${widget.cnic}');
//                         log('address: ${widget.currentAddress}');
//                         log('gender: ${widget.gender}');
//                         log('cast: ${widget.cast}');
//                         log('religion: ${widget.religion}');
//                         log('sect: ${widget.sect}');
//                         log('maritalStatus: ${widget.maritalStatus}');
//                         log('job: ${widget.job}');
//                         log('kids: ${widget.kids}');
//                         log('qualification: ${widget.qualification}');
//                         log('height: ${widget.height}');
//                         log('weight: ${widget.weight}');
//                         log('age: ${widget.age}');
//                         log("city: ${widget.city}");
//                         log("province: ${widget.province}");
//                         log("smoking: ${widget.smoking}");
//                         log('disability: ${widget.disability}');
//                         log('skinColor: ${widget.skinColor}');
//                         log('brother: ${widget.brother}');
//                         log('sister: ${widget.sister}');
//                         log('bio: ${bioController.text}');
//                         log('interest: ${interestController.text}');
//                         log('partnerpref: ${prefrencesController.text}');
//                         log('dateOfBirth: ${dateOfBirth.toString()}');
//                         log('image: ${image}');