import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/reviews_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewsRepository {
  Stream<List<ReviewsModel>> getReviewsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('reviews')
        .orderBy('rating', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ReviewsModel(
          title: doc['title'],
          rating: doc['rating'],
          id: doc.id,
        );
      }).toList();
    });
  }

  Future<void> delete({
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

  Future<void> addReviews(
      {required String title, required double rating}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('reviews')
        .add({
      'title': title,
      'rating': rating,
    });
  }
}
