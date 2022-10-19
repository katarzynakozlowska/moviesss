import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/watch_model.dart';
import 'package:curlzzz_new/repositories/watch_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'to_watch_state.dart';

class ToWatchCubit extends Cubit<ToWatchState> {
  ToWatchCubit(
    this._watchRepository,
  ) : super(
          const ToWatchState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  final WatchRepository _watchRepository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const ToWatchState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );
    _streamSubscription =
        _watchRepository.getWatchStream().listen((watchItems) {
      emit(
        ToWatchState(
          documents: watchItems,
          errorMessage: '',
          isLoading: false,
        ),
      );
    })
          ..onError((error) {
            emit(
              ToWatchState(
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
