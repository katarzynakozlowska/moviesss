// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:curlzzz_new/repositories/reviews_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'add_reviews_state.dart';

class AddReviewsCubit extends Cubit<AddReviewsState> {
  AddReviewsCubit(this._reviewsRepository) : super(const AddReviewsState());

  final ReviewsRepository _reviewsRepository;

  Future<void> addReviews({
    required String title,
    required double rating,
  }) async {
    try {
      await _reviewsRepository.addReviews(
        rating: rating,
        title: title,
      );
      emit(const AddReviewsState(
        saved: true,
      ));
    } catch (error) {
      emit(
        AddReviewsState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
