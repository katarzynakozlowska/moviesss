part of 'upcoming_movies_cubit.dart';

@immutable
class UpcomingMoviesState {
  UpcomingMoviesState({
     this.documents =const[],
     this.errorMessage='',
     this.isLoading=false,
  });

  final List<UpcomingModel> documents;
  final String errorMessage;
  final bool isLoading;
}
