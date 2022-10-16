import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_upcoming_movies_state.dart';

class AddUpcomingMoviesCubit extends Cubit<AddUpcomingMoviesState> {
  AddUpcomingMoviesCubit() : super(AddUpcomingMoviesInitial());
}
