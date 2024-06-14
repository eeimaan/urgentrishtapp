import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/providers/dialogue_provider.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class BasicInformationScreen extends StatefulWidget {
  final String email;
  final String name;
  final String password;
  final String fatherName;
  final String motherName;
  final String phone;
  final String cnic;
  final String currentAddress;
  final String cnicAddress;

  const BasicInformationScreen(
      {super.key,
      required this.email,
      required this.password,
      required this.name,
      required this.fatherName,
      required this.motherName,
      required this.phone,
      required this.cnic,
      required this.currentAddress,
      required this.cnicAddress});

  @override
  State<BasicInformationScreen> createState() =>
      _BasicInformationMoreScreenState();
}

class _BasicInformationMoreScreenState extends State<BasicInformationScreen> {
  TextEditingController castController = TextEditingController(text: "General");
  TextEditingController genderController = TextEditingController(text: "Male");
  TextEditingController religionController =
      TextEditingController(text: "Christianity");
  TextEditingController sectController =
      TextEditingController(text: "Catholic");
  TextEditingController jobController = TextEditingController(text: "job");
  TextEditingController weightController = TextEditingController(text: "70");
  TextEditingController homeController = TextEditingController(text: "own");
  TextEditingController qualificationController =
      TextEditingController(text: "Bachelor's Degree");
  TextEditingController heightController = TextEditingController(text: "5ft");
  TextEditingController ageController = TextEditingController(text: "30");
  ValueNotifier<String> castValueNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    castValueNotifier.addListener(_updateCityController);
  }

  @override
  void dispose() {
    castValueNotifier.removeListener(_updateCityController);
    super.dispose();
  }

  void _updateCityController() {
    castController.text = castValueNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController maritalStatusController =
        Provider.of<MaritalStatusProvider>(context).controller;
    TextEditingController kidsController = TextEditingController();

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
                const Text(
                  'Gender',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your gender',
                  obscureText: false,
                  controller: genderController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please select gender';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.genderList,
                    controller: genderController,
                    onChanged: (String? selectedOption) {
                      genderController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Age',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your age',
                  obscureText: false,
                  controller: ageController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter age';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.ageList,
                    controller: ageController,
                    onChanged: (String? selectedOption) {
                      ageController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Height',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your height',
                  obscureText: false,
                  controller: heightController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter height';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.heightList,
                    controller: heightController,
                    onChanged: (String? selectedOption) {
                      heightController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Weight',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your weight',
                  obscureText: false,
                  controller: weightController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter weight';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.weightList,
                    controller: weightController,
                    onChanged: (String? selectedOption) {
                      weightController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Religion',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your religion',
                  obscureText: false,
                  controller: religionController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please select religion';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.religionList,
                    controller: religionController,
                    onChanged: (String? selectedOption) {
                      religionController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Sect',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your sect',
                  obscureText: false,
                  controller: sectController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please select sect';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.sectList,
                    controller: sectController,
                    onChanged: (String? selectedOption) {
                      sectController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Cast',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your cast',
                  obscureText: false,
                  controller: castController,
                  onChanged: (input) {
                    castValueNotifier.value = input;
                  },
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter cast';
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
                            child: CastDialogWidget(
                              onSelected: (selectedCast) {
                                castValueNotifier.value = selectedCast;
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
                  'Marital Status',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your marital status',
                  obscureText: false,
                  controller: maritalStatusController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter status';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.maritalStatusList,
                    controller: maritalStatusController,
                    onChanged: (String? selectedOption) {
                      Provider.of<MaritalStatusProvider>(context, listen: false)
                          .updateMaritalStatus(selectedOption ?? '');
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<MaritalStatusProvider>(
                  builder: (context, provider, _) {
                    return Visibility(
                      visible:
                          provider.controller.text.toLowerCase() != 'single',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Kids',
                            style: TextStyle(fontSize: FontConstants.large),
                          ),
                          TextFieldWidget(
                            readOnly: true,
                            hintText: 'Choose your kids',
                            obscureText: false,
                            controller: kidsController,
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return 'Please enter kids';
                              }
                              return null;
                            },
                            suffixIcon: DropDownsWidget(
                              itemList: TextConstants.noList,
                              controller: kidsController,
                              onChanged: (String? selectedOption) {
                                kidsController.text = selectedOption ?? '';
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Job/Bussines',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your Job/Bussines',
                  obscureText: false,
                  controller: jobController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter job/bussiness';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.jobAndBusinessList,
                    controller: jobController,
                    onChanged: (String? selectedOption) {
                      jobController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Home',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your home',
                  obscureText: false,
                  controller: homeController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter home';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.homeStatusList,
                    controller: homeController,
                    onChanged: (String? selectedOption) {
                      homeController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Qualification',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  readOnly: true,
                  hintText: 'Choose your qualification',
                  obscureText: false,
                  controller: qualificationController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter qualification';
                    }
                    return null;
                  },
                  suffixIcon: DropDownsWidget(
                    itemList: TextConstants.qualificationList,
                    controller: qualificationController,
                    onChanged: (String? selectedOption) {
                      qualificationController.text = selectedOption ?? '';
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: ButtonWidget(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.basicInfoMore, arguments: {
                              'email': widget.email,
                              'name': widget.name,
                              'fatherName': widget.fatherName,
                              'motherName': widget.motherName,
                              'phoneNo': widget.phone,
                              'password': widget.password,
                              'cnic': widget.cnic,
                              'address': widget.currentAddress,
                              'gender': genderController.text,
                              'cast': castController.text,
                              'religion': religionController.text,
                              'sect': sectController.text,
                              'home': homeController.text,
                              'maritalStatus': maritalStatusController.text,
                              'job': jobController.text,
                              'kids': kidsController.text,
                              'qualification': qualificationController.text,
                              'height': heightController.text,
                              'weight': weightController.text,
                              'age': ageController.text,
                              'cnicAddress': widget.cnicAddress
                            });
                            log('email: ${widget.email}');
                            log('name: ${widget.name}');
                            log('fatherName: ${widget.fatherName}');
                            log('motherName: ${widget.motherName}');
                            log('phoneNo: ${widget.phone}');
                            log('password: ${widget.password}');
                            log('cnic: ${widget.cnic}');
                            log('address: ${widget.currentAddress}');
                            log('gender: ${genderController.text}');
                            log('cast: ${castController.text}');
                            log('religion: ${religionController.text}');
                            log('sect: ${sectController.text}');
                            log('maritalStatus: ${maritalStatusController.text}');
                            log('job: ${jobController.text}');
                            log('home:${homeController.text}');
                            log('kids: ${kidsController.text}');
                            log('qualification: ${qualificationController.text}');
                            log('height: ${heightController.text}');
                            log('weight: ${weightController.text}');
                            log('age: ${ageController.text}');
                          }
                        },
                        text: TextConstants.next,
                        width: 350,
                        btnColor:  ColorConstants.orange,
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
