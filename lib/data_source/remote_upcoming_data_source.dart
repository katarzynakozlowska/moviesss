import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpcomingRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getUpcomingRemoteData() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('upcoming')
        .orderBy('date', descending: false)
        .snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>?> addUpcomingRemoteData({
    required String title,
    required String url,
    required DateTime date,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('upcoming')
        .add({
      'title': title,
      'url': url,
      'date': date,
    });
  }

  Future<void> deleteUpcomingRemoteData({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('upcoming')
        .doc(id)
        .delete();
  }
}
