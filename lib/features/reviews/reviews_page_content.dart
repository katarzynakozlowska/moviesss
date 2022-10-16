import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/features/add_reviews/add_reviews_page_content.dart';
import 'package:curlzzz_new/features/reviews/cubit/reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddReview(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: BlocProvider(
        create: (context) => ReviewsCubit()..start(),
        child: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Text(
                'Something went wrong: ${state.errorMessage}',
              );
            }
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = state.documents;
            return ListView(
              children: [
                for (final document in documents) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('reviews')
                          .doc(document.id)
                          .delete();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.all(10.0),
                        color: const Color.fromARGB(255, 243, 177, 198),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(document['title']),
                            Text(document['rating'].toString())
                          ],
                        )),
                  )
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
