import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/upcoming_model.dart';
import 'package:meta/meta.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {
  UpcomingMoviesCubit()
      : super(
          UpcomingMoviesState(
            documents: const [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  Future<void> dismiss({required String id}) async {
    await FirebaseFirestore.instance.collection('upcoming').doc(id).delete();
  }

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      UpcomingMoviesState(
        documents: const [],
        errorMessage: '',
        isLoading: true,
      ),
    );
    _streamSubscription = FirebaseFirestore.instance
        .collection('upcoming')
        .snapshots()
        .listen((data) {
      final upcomingModels = data.docs.map((doc) {
        return UpcomingModel(
          title: doc['title'],
          url: doc['url'],
          date: (doc['date'] as Timestamp).toDate(),
          id: doc.id,
        );
      }).toList();
      emit(
        UpcomingMoviesState(
          documents: upcomingModels,
          errorMessage: '',
          isLoading: false,
        ),
      );
    })
      ..onError((error) {
        emit(
          UpcomingMoviesState(
            documents: const [],
            errorMessage: error.toString(),
            isLoading: false,
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
