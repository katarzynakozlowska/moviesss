import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/features/add_reviews/cubit/add_reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        appBar: AppBar(title: Text('Add review')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Movie title'),
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
              create: (context) => AddReviewsCubit(),
              child: BlocListener<AddReviewsCubit, AddReviewsState>(
                listener: (context, state) {
                  if (state.saved == true) {
                    Navigator.of(context).pop();
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
                        child: Text('Add'));
                  },
                ),
              ),
            )
          ],
        )));
  }
}
