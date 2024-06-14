import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class BasicInformationMoreScreen extends StatefulWidget {
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
  final String home;
  final String job;
  final String? kids;
  final String qualification;
  final String height;
  final String weight;
  final String age;
  final String cnicAddress;
  const BasicInformationMoreScreen(
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
      required this.cnicAddress});

  @override
  State<BasicInformationMoreScreen> createState() =>
      _BasicInformationMoreScreenState();
}

class _BasicInformationMoreScreenState
    extends State<BasicInformationMoreScreen> {
  TextEditingController cityController =
      TextEditingController(text: "New York");
  TextEditingController smokingController = TextEditingController(text: "No");
  TextEditingController disabilityController =
      TextEditingController(text: "None");
  TextEditingController skinColorController =
      TextEditingController(text: "Fair");
  TextEditingController motherAliveController =
      TextEditingController(text: "yes");
  TextEditingController fatherAliveController =
      TextEditingController(text: "yes");
  TextEditingController jointFamilyController =
      TextEditingController(text: "yes");
  TextEditingController brotherController = TextEditingController(text: "2");
  TextEditingController sisterController = TextEditingController(text: "1");
  TextEditingController provinceController =
      TextEditingController(text: "New York State");
  ValueNotifier<String> cityValueNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    cityValueNotifier.addListener(_updateCityController);
  }

  @override
  void dispose() {
    cityValueNotifier.removeListener(_updateCityController);
    super.dispose();
  }

  void _updateCityController() {
    cityController.text = cityValueNotifier.value;
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
          'Basic Information',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'How many Brothers?',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose option',
                  obscureText: false,
                  controller: brotherController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.noList,
                    controller: brotherController,
                    onChanged: (String? selectedOption) {
                      brotherController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'How many Sisters?',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose option',
                  obscureText: false,
                  controller: sisterController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.noList,
                    controller: sisterController,
                    onChanged: (String? selectedOption) {
                      sisterController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Mother Alive',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose option',
                  obscureText: false,
                  controller: motherAliveController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.yesNoList,
                    controller: motherAliveController,
                    onChanged: (String? selectedOption) {
                      motherAliveController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Father Alive',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose option',
                  obscureText: false,
                  controller: fatherAliveController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.yesNoList,
                    controller: fatherAliveController,
                    onChanged: (String? selectedOption) {
                      fatherAliveController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Joint Family',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose option',
                  obscureText: false,
                  controller: jointFamilyController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.yesNoList,
                    controller: jointFamilyController,
                    onChanged: (String? selectedOption) {
                      jointFamilyController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Province',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your province',
                  obscureText: false,
                  controller: provinceController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter province';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.provinceList,
                    controller: provinceController,
                    onChanged: (String? selectedOption) {
                      provinceController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'City',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your city',
                  obscureText: false,
                  controller: cityController,
                  onChanged: (input) {
                    cityValueNotifier.value = input;
                  },
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            surfaceTintColor: Colors.white,
                            child: CityDialogWidget(
                              onCitySelected: (selectedCity) {
                                cityValueNotifier.value = selectedCity;
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Skin colour',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your skin colour',
                  obscureText: false,
                  controller: skinColorController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter skin color';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.skinColorList,
                    controller: skinColorController,
                    onChanged: (String? selectedOption) {
                      skinColorController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Smoking',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose option',
                  obscureText: false,
                  controller: smokingController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.yesNoList,
                    controller: smokingController,
                    onChanged: (String? selectedOption) {
                      smokingController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Disability',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose option',
                  obscureText: false,
                  controller: disabilityController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.yesNoList,
                    controller: disabilityController,
                    onChanged: (String? selectedOption) {
                      disabilityController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                    child: ButtonWidget(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            log('email: ${widget.email}');
                            log('name: ${widget.name}');
                            log('fatherName: ${widget.fatherName}');
                            log('motherName: ${widget.motherName}');
                            log('phoneNo: ${widget.phone}');
                            log('password: ${widget.password}');
                            log('cnic: ${widget.cnic}');
                            log('address: ${widget.currentAddress}');
                            log('gender: ${widget.gender}');
                            log('cast: ${widget.cast}');
                            log('religion: ${widget.religion}');
                            log('sect: ${widget.sect}');
                            log('maritalStatus: ${widget.maritalStatus}');
                            log('job: ${widget.job}');
                            log('kids: ${widget.kids}');
                            log('qualification: ${widget.qualification}');
                            log('height: ${widget.height}');
                            log('weight: ${widget.weight}');
                            log('age: ${widget.age}');
                            log("city: ${cityController.text}");
                            log("province: ${provinceController.text}");
                            log("smoking: ${smokingController.text}");
                            log('disability: ${disabilityController.text}');
                            log('skinColor: ${skinColorController.text}');
                            log('brother: ${brotherController.text}');
                            log('sister: ${sisterController.text}');

                            Navigator.of(context)
                                .pushNamed(AppRoutes.profile, arguments: {
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
                              "city": cityController.text,
                              "province": provinceController.text,
                              "smoking": smokingController.text,
                              'disability': disabilityController.text,
                              'skinColor': skinColorController.text,
                              'brother': brotherController.text,
                              'sister': sisterController.text,
                              'cnicAddress': widget.cnicAddress,
                              'motherAlive': motherAliveController.text,
                              'fatherAlive': fatherAliveController.text,
                              'jointFamily': jointFamilyController.text,
                            });
                          }
                        },
                        text: 'Next',
                        width: 350,
                        btnColor:  ColorConstants.orange,
                        textColor: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
