import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_upcoming_movies_state.dart';

class AddUpcomingMoviesCubit extends Cubit<AddUpcomingMoviesState> {
  AddUpcomingMoviesCubit() : super(AddUpcomingMoviesState());

  Future<void> upcoming(
    String title,
    String url,
    DateTime date,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('upcoming').add({
        'title': title,
        'url': url,
        'date': date,
      });
      emit(AddUpcomingMoviesState(
        saved: true,
      ));
    } catch (error) {
      emit(AddUpcomingMoviesState(errorMessage: error.toString()));
    }
  }
}
