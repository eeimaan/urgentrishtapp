import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';

class DbAuthService {
  static Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String fatherName,
    required String motherName,
    required String phoneNo,
    required String cnic,
    required String home,
    required String address,
    required String gender,
    required String cast,
    required String religion,
    required String sect,
    required String maritalStatus,
    required String job,
    String? kids,
    required String qualification,
    required String height,
    required String weight,
    required String age,
    required String city,
    required String province,
    required String smoking,
    required String disability,
    required String skinColor,
    required String brother,
    required String sister,
    required String interest,
    required String bio,
    required String dateOfBirth,
    required String partnerPref,
    required File image,
    required File frontCnic,
    required File backCnic,
    required File imageSelfie,
    required String paymentStatus,
    required String verifyByAdminStatus,
    required String cnicAddress,
    required String motherAlive,
    required String fatherAlive,
    required String jointFamily,
    required String role,
    required BuildContext context,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: email)
          .where('role', isEqualTo: 'admin')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Access denied: The email is already registered with the role admin.'),
            backgroundColor: Colors.red,
          ),
        );
        throw FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'The email is already registered with the role admin',
        );
      }
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      Future<String> uploadFile(File file, String path) async {
        Reference storageReference = FirebaseStorage.instance.ref().child(path);
        UploadTask uploadTask = storageReference.putFile(file);
        TaskSnapshot taskSnapshot = await uploadTask;
        return await taskSnapshot.ref.getDownloadURL();
      }

      String imageUrl =
          await uploadFile(image, 'users/$uid/images/profile_image.jpg');

      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.updatePhotoURL(imageUrl);

      String frontCnicUrl =
          await uploadFile(frontCnic, 'users/$uid/images/front_cnic.jpg');
      String backCnicUrl =
          await uploadFile(backCnic, 'users/$uid/images/back_cnic.jpg');
      String imageSelfieUrl =
          await uploadFile(imageSelfie, 'users/$uid/images/selfie.jpg');

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'bio': bio,
        'image_url': imageUrl,
        'father_name': fatherName,
        'mother_name': motherName,
        'phone_no': phoneNo,
        'cnic': cnic,
        'home': home,
        'address': address,
        'email': email,
        'gender': gender,
        'cast': cast,
        'religion': religion,
        'sect': sect,
        'marital_status': maritalStatus,
        'job': job,
        'kids': kids,
        'qualification': qualification,
        'height': height,
        'weight': weight,
        'age': age,
        'city': city,
        'province': province,
        'smoking': smoking,
        'disability': disability,
        'skin_color': skinColor,
        'brother': brother,
        'sister': sister,
        'interest': interest,
        'partner_preference': partnerPref,
        'date_of_birth': dateOfBirth,
        'front_cnic_url': frontCnicUrl,
        'back_cnic_url': backCnicUrl,
        'selfie_url': imageSelfieUrl,
        'payment_status': paymentStatus,
        'verify_by_admin_status': verifyByAdminStatus,
        'cnic_address': cnicAddress,
        'mother_alive': motherAlive,
        'father_alive': fatherAlive,
        'joint_family': jointFamily,
        'role': role,
      });
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      log('$e');
      rethrow;
    }
  }

  static Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists && userDoc['role'] == 'user') {
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.pendingStatus,
            (Route<dynamic> route) => false,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Access denied: inValid mail'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        default:
          errorMessage = 'An error occurred: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login,
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Handle errors, such as displaying an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $e'),
        ),
      );
    }
  }

  static Future<void> resetPassword(String email, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('email', isEqualTo: email)
          .where('role', isEqualTo: 'user')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Access denied: The email is registered with another role'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        List<String> signInMethods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (signInMethods.isNotEmpty) {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Password reset email sent. Please check your email.'),
            ),
          );
        } else {
          // Email is not registered
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This email is not registered.'),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send password reset email: $e'),
        ),
      );
    }
  }

  static Future<void> deleteUser(BuildContext context) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'no-user',
          message: 'No user currently signed in.',
        );
      }

      String uid = user.uid;

      Reference imagesRef = FirebaseStorage.instance.ref('users/$uid/images');

      await imagesRef.listAll().then((result) async {
        for (var item in result.items) {
          await item.delete();
        }
        for (var prefix in result.prefixes) {
          await _deleteFolder(prefix);
        }
      });

      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');
      DocumentReference userDoc = userCollection.doc(uid);
      await userDoc.delete();

      await user.delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account successfully deleted')),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  }

  static Future<void> _deleteFolder(Reference ref) async {
    final listResult = await ref.listAll();

    for (var item in listResult.items) {
      await item.delete();
    }

    for (var prefix in listResult.prefixes) {
      await _deleteFolder(prefix);
    }

    await ref.delete();
  }

  static User? get getCurrentUser {
    return FirebaseAuth.instance.currentUser;
  }
}
