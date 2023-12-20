import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../provider/user_firebase.dart';

class UserAccount extends GetxController {
  String uid;
  String username;
  String status;
  String imageUrl;
  String phoneNumber;
  String jobDescrption;

  List<UserAccount> friends;

  UserAccount({
    this.uid = '',
    this.username = '',
    this.status = '',
    this.imageUrl = '',
    this.phoneNumber = '',
    this.friends = const [],
    this.jobDescrption = '',
  });

  static final Rx<UserAccount?> _currentUser = Rx<UserAccount?>(null);

  static UserAccount? get currentUser => _currentUser.value;

  static set currentUser(UserAccount? newUser) => _currentUser(newUser);

  static Future<void> init() async {
    Get.put(UserAccount());

    await _bindUserChanges();
  }

  static const String _collection = "users";
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> _bindUserChanges() async {
    try {
      String? uuid = FirebaseAuth.instance.currentUser?.uid;

      if (uuid == null) {
        currentUser = null;
        return;
      }
      final event = await _db.collection(_collection).doc(uuid).get();
      currentUser = fromDoc(event);
    } catch (_) {
      FirebaseAuth.instance.signOut();
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uid,
      'username': username,
      'status': status,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'jobDescrption': jobDescrption,
    };
  }

  factory UserAccount.fromMap(
      {required String uuid, required Map<String, dynamic> map}) {
    return UserAccount(
      uid: uuid,
      username: map['username'] as String,
      status: map['status'] as String,
      imageUrl: map['imageUrl'] as String,
      phoneNumber: map['phoneNumber'] as String,
      jobDescrption: map['jobDescrption'] as String,
    );
  }

  static UserAccount? fromDoc(DocumentSnapshot doc) {
    try {
      log('fromDoc: ${doc.data()}');
      final data = doc.data() as Map<String, dynamic>;
      return UserAccount.fromMap(uuid: doc.id, map: data);
    } catch (_) {
      return null;
    }
  }

  UserAccount copyWith({
    String? uid,
    String? username,
    String? status,
    String? imageUrl,
    String? phoneNumber,
    String? jobDescrption,

  }) {
    return UserAccount(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      jobDescrption: jobDescrption ?? this.jobDescrption,
    );
  }

  @override
  String toString() {
    return '''UserAccount [] (
      uuid: $uid,
      username: $username,
      status: $status,
      imageUrl: $imageUrl,
      phoneNumber: $phoneNumber,
      jobDescrption: $jobDescrption,
    )''';
  }

  Future<void> updateCurrentUser() async {
    try {
      currentUser = this;
      await UserFirebase.updateUser(userAccount: this);
      update();
    } catch (e) {
      if (kDebugMode) {
        print('error updating user account: $e');
      }
    }
  }
}
