import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteWatchDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getRemoteWatchStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('movies')
        .snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>?> addRemoteWatchData({
    required String title,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('movies')
        .add(
      {'title': title},
    );
  }

  Future<void> dismissRemoteData({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection(
          'movies',
        )
        .doc(id)
        .delete();
   
  }
}
