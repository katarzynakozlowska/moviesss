part of 'add_reviews_cubit.dart';

@immutable
class AddReviewsState {
  final bool saved;
  final String errorMessage;

  const AddReviewsState({
    this.saved = false,
    this.errorMessage = '',
  });
}
