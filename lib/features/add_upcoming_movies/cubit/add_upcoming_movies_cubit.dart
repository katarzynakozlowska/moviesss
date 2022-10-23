// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:curlzzz_new/repositories/upcoming_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'add_upcoming_movies_state.dart';

class AddUpcomingMoviesCubit extends Cubit<AddUpcomingMoviesState> {
  AddUpcomingMoviesCubit(
    this._upcomingReposiroty,
  ) : super(const AddUpcomingMoviesState());

  final UpcomingReposiroty _upcomingReposiroty;

  Future<void> upcoming(
    String title,
    String url,
    DateTime date,
  ) async {
    try {
      await _upcomingReposiroty.addUpcoming(
        date: date,
        title: title,
        url: url,
      );
      emit(const AddUpcomingMoviesState(
        saved: true,
      ));
    } catch (error) {
      emit(AddUpcomingMoviesState(errorMessage: error.toString()));
    }
  }
}
