import 'package:curlzzz_new/features/add_reviews/cubit/add_reviews_cubit.dart';
import 'package:curlzzz_new/repositories/reviews_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReview extends StatefulWidget {
  const AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  var movieTitle = '';
  var movieRating = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add review')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: const InputDecoration(hintText: 'Movie title'),
                onChanged: (newValue) {
                  setState(() {
                    movieTitle = newValue;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Slider(
              value: movieRating,
              onChanged: (newValue) {
                setState(
                  () {
                    movieRating = newValue;
                  },
                );
              },
              min: 1.0,
              max: 10.0,
              divisions: 9,
              label: movieRating.toString(),
            ),
            BlocProvider(
              create: (context) => AddReviewsCubit(ReviewsRepository()),
              child: BlocListener<AddReviewsCubit, AddReviewsState>(
                listener: (context, state) {
                  if (state.saved == true) {
                    Navigator.of(context).pop();
                  }
                  if (state.errorMessage.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<AddReviewsCubit, AddReviewsState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: movieTitle.isEmpty
                            ? null
                            : () {
                                context.read<AddReviewsCubit>().addReviews(
                                      title: movieTitle,
                                      rating: movieRating.toString(),
                                    );
                              },
                        child: const Text('Add'));
                  },
                ),
              ),
            )
          ],
        )));
  }
}
