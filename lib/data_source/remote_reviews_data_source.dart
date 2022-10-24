import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getReviewsRemoteData() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('reviews')
        .orderBy('rating', descending: true)
        .snapshots();
  }

  Future<void> deleteRemoteData({
    required String id,
  }) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection(
          'reviews',
        )
        .doc(id)
        .delete();
  }

  Future<DocumentReference<Map<String, dynamic>>?> addRemoteReviewsData(
      {required String title, required double rating}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('reviews')
        .add({
      'title': title,
      'rating': rating,
    });
  }
}
