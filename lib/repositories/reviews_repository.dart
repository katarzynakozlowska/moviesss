import 'package:curlzzz_new/data_source/remote_reviews_data_source.dart';
import 'package:curlzzz_new/models/reviews_model.dart';

class ReviewsRepository {
  ReviewsRepository(this._reviewsRemoteDataSource);
  final ReviewsRemoteDataSource _reviewsRemoteDataSource;

  Stream<List<ReviewsModel>> getReviewsStream() {
    return _reviewsRemoteDataSource.getReviewsRemoteData().map((querySnapshot) {
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
    return _reviewsRemoteDataSource.deleteRemoteData(id: id);
  }

  Future<void> addReviews({required String title, required double rating}) {
    return _reviewsRemoteDataSource.addRemoteReviewsData(
        title: title, rating: rating);
  }
}
