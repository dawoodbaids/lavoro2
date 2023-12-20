import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class UserRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // create a static method to get all freinds user from firebase.
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllFreinds() {
    // get the current user id.
    String currentUserId = UserAccount.currentUser!.uid;

    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('friends')
        .snapshots();
  }
}
