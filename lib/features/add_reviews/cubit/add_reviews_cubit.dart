import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_reviews_state.dart';

class AddReviewsCubit extends Cubit<AddReviewsState> {
  AddReviewsCubit() : super(const AddReviewsState());

  Future<void> addReviews({
    required String title,
    required String rating,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('reviews')
          .add({'title': title, 'rating': rating});
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
