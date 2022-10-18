part of 'add_upcoming_movies_cubit.dart';

@immutable
class AddUpcomingMoviesState {
  AddUpcomingMoviesState({
    this.errorMessage = '',
    this.saved = false,
  });

  final String errorMessage;
  final bool saved;
}
