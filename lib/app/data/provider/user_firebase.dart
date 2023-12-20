import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/user_model.dart';

class UserFirebase {
  static const String _collection = "users";
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static String? get uuid => UserAccount.currentUser?.uid;

  static Future<UserAccount?> getUser(final String uuid) async {
    try {
      final data = await _db.collection(_collection).doc(uuid).get();

      return UserAccount.fromDoc(data);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<void> setUser({required UserAccount userAccount}) async {
    try {
      await _db
          .collection(_collection)
          .doc(userAccount.uid)
          .set(userAccount.toMap());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  static Future<void> updateUser({required UserAccount userAccount}) async {
    try {
      await _db.collection(_collection).doc(uuid).update(userAccount.toMap());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  static Future<String?> uploadUserImage({
    required String imagePath,
    required String uuid,
  }) async {
    log('''
    -------------------------
    | path: $imagePath,     |
    | uuid: $uuid,          |
    -------------------------
    ''');

    try {
      File uploadFile = File(imagePath);

      final TaskSnapshot uploadTask = await FirebaseStorage.instance
          .ref('users/$uuid/profile_image')
          .putFile(uploadFile);

      final String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log('Error uploading user image: $e,\n $imagePath');
      return null;
    }
  }
}
