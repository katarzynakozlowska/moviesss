import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/reviews_model.dart';
import 'package:meta/meta.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit()
      : super(const ReviewsState(
          documents: [],
          errorMessage: '',
          isLoading: false,
        ));

  Future<void> dismiss({required String id}) async {
    await FirebaseFirestore.instance
        .collection(
          'reviews',
        )
        .doc(id)
        .delete();
  }

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
      final reviewsModels = data.docs.map((doc) {
        return ReviewsModel(
          title: doc['title'],
          rating: doc['rating'],
          id: doc.id,
        );
      }).toList();
      emit(ReviewsState(
        documents: reviewsModels,
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
