import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            final documents = snapshot.data!.docs;
            return ListView(children: [
              for (final document in documents) ...[
                Container(
                    padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.all(10.0),
                    color: Color.fromARGB(255, 243, 177, 198),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(document['title']),
                        Text(document['rating'].toString())
                      ],
                    ))
              ]
            ]);
          }),
    );
  }
}
