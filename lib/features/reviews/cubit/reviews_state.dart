part of 'reviews_cubit.dart';

@immutable
class ReviewsState {
  const ReviewsState({
    required this.documents,
    required this.errorMessage,
    required this.isLoading,
  });

  final List<ReviewsModel> documents;
  final String errorMessage;
  final bool isLoading;
}
