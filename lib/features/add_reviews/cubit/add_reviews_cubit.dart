import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_reviews_state.dart';

class AddReviewsCubit extends Cubit<AddReviewsState> {
  AddReviewsCubit() : super(AddReviewsState());
}
