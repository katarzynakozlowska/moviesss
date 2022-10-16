import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit()
      : super(const ReviewsState(
          documents: [],
          errorMessage: '',
          isLoading: false,
        ));
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const ReviewsState(
      documents: [],
      errorMessage: '',
      isLoading: true,
    ));
    _streamSubscription = FirebaseFirestore.instance
        .collection('reviews')
        .orderBy('rating', descending: true)
        .snapshots()
        .listen((data) {
      emit(ReviewsState(
        documents: data.docs,
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
}
