import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:curlzzz_new/models/reviews_model.dart';
import 'package:curlzzz_new/repositories/reviews_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(this._reviewsRepository)
      : super(const ReviewsState(
          documents: [],
          errorMessage: '',
          isLoading: false,
        ));

  final ReviewsRepository _reviewsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const ReviewsState(
      documents: [],
      errorMessage: '',
      isLoading: true,
    ));
    _streamSubscription =
        _reviewsRepository.getReviewsStream().listen((reviews) {
      emit(ReviewsState(
        documents: reviews,
        errorMessage: '',
        isLoading: false,
      ));
    })
          ..onError((error) {
            emit(ReviewsState(
              documents: const [],
              errorMessage: error.toString(),
              isLoading: false,
            ));
          });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  Future<void> dismiss({required String id}) async {
    await _reviewsRepository.delete(id: id);
  }
}
