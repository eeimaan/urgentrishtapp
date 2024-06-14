import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/data_service.dart';
import 'package:urgentrishtapp/utils/utils.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final ValueNotifier<File?> imageEditNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();
  late TextEditingController bioController;
  late TextEditingController nameController;
  String? imageUrl;
  String? userId;

  @override
  void initState() {
    super.initState();
    bioController = TextEditingController();
    nameController = TextEditingController();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      bioController.text = data['bio'] ?? '';
      nameController.text = data['name'] ?? '';
      imageUrl = data['image_url'];
    }
    setState(() {});
  }

  @override
  void dispose() {
    imageEditNotifier.dispose();
    isLoadingNotifier.dispose();
    bioController.dispose();
    nameController.dispose();
    super.dispose();
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
        centerTitle: true,
        title: const Text(
          'Edit profile',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge, fontWeight: FontWeight.w500),
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
                          valueListenable: imageEditNotifier,
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
                                  ? (imageUrl != null
                                      ? ClipOval(
                                          child: Image.network(
                                            imageUrl!,
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Center(
                                                child:
                                                    CupertinoActivityIndicator(),
                                              );
                                            },
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                              return const Icon(
                                                Icons.person_outlined,
                                                color: ColorConstants.purple,
                                                size: 70,
                                              );
                                            },
                                          ),
                                        )
                                      : const Icon(
                                          Icons.person_outlined,
                                          color: ColorConstants.purple,
                                          size: 70,
                                        ))
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
                              File? image = await AppUtils.pickImage();

                              if (image != null) {
                                imageEditNotifier.value = image;
                              }
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
                const Text(
                  'Name',
                  style: TextStyle(fontSize: FontConstants.large),
                ),
                TextFieldWidget(
                  hintText: 'Enter name',
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
                Center(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isLoadingNotifier,
                    builder: (context, isLoading, child) {
                      return isLoading
                          ? const CupertinoActivityIndicator()
                          : ButtonWidget(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  isLoadingNotifier.value = true;
                                  try {
                                    await UserProfileService().updateProfile(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      imageFile: imageEditNotifier.value ??
                                          (imageUrl != null
                                              ? File(imageUrl!)
                                              : null),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Updated successfully'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to update : $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } finally {
                                    isLoadingNotifier.value = false;
                                  }
                                }
                              },
                              text: 'Save',
                              width: 350,
                             btnColor: ColorConstants.orange,
                              textColor: Colors.black,
                            );
                    },
                  ),
                ),
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
