part of 'upcoming_movies_cubit.dart';

@immutable
class UpcomingMoviesState {
  UpcomingMoviesState({
    required this.documents,
    required this.errorMessage,
    required this.isLoading,
  });

  final List<QueryDocumentSnapshot<Object?>> documents;
  final String errorMessage;
  final bool isLoading;
}
