import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
            ElevatedButton(
                onPressed: movieTitle.isEmpty
                    ? null
                    : () {
                        FirebaseFirestore.instance.collection('reviews').add({
                          'title': movieTitle,
                          'rating': movieRating,
                        });
                      },
                child: Text('Add'))
          ],
        )));
  }
}
