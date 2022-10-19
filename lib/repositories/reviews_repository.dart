import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/reviews_model.dart';

class ReviewsRepository {
  Stream<List<ReviewsModel>> getReviewsStream() {
    return FirebaseFirestore.instance
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
    return FirebaseFirestore.instance
        .collection(
          'reviews',
        )
        .doc(id)
        .delete();
  }

  Future<void> addReviews(
      {required String title, required String rating}) async {
    await FirebaseFirestore.instance.collection('reviews').add({
      'title': title,
      'rating': rating,
    });
  }
}
