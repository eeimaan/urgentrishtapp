import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urgentrishtapp/db_service/auth.dart';
import 'package:urgentrishtapp/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DbDataService {
  DbDataService();

  Stream<List<UserData>> streamAllUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('verify_by_admin_status', isEqualTo: 'yes')
        .where('payment_status', isEqualTo: 'yes')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .where((doc) => doc.id != DbAuthService.getCurrentUser!.uid)
          .map((doc) {
        return UserData.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}

class UserProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> updateProfile({
    required String name,
    required String bio,
    File? imageFile,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user is signed in');
      }
      String uid = user.uid;

      String? imageUrl;

      if (imageFile != null) {
        String filePath = 'users/$uid/images/profile_image.jpg';
        UploadTask uploadTask = _storage.ref(filePath).putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      await _firestore.collection('users').doc(uid).update({
        'name': name,
        'bio': bio,
        'image_url': imageUrl,
      });

      log('Profile updated successfully');
    } catch (e) {
      log('Failed to update profile: $e');
      rethrow;
    }
  }
}
