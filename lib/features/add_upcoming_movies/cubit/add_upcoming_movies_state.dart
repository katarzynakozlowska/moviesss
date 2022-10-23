part of 'add_upcoming_movies_cubit.dart';

@immutable
class AddUpcomingMoviesState {
  const AddUpcomingMoviesState({
    this.errorMessage = '',
    this.saved = false,
  });

  final String errorMessage;
  final bool saved;
}
