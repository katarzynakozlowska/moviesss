import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/upcoming_model.dart';
import 'package:curlzzz_new/repositories/upcoming_repository.dart';
import 'package:meta/meta.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {
  UpcomingMoviesCubit(this._upcomingRepository)
      : super(
          UpcomingMoviesState(
            documents: const [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final UpcomingReposiroty _upcomingRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      UpcomingMoviesState(
        documents: const [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription =
        _upcomingRepository.getUpcomingStream().listen((upcomingItems) {
      emit(
        UpcomingMoviesState(
          documents: upcomingItems,
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

  Future<void> dismiss({required String id}) async {
    await FirebaseFirestore.instance.collection('upcoming').doc(id).delete();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
