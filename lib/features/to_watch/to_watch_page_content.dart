import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ToWatchPage extends StatelessWidget {
  ToWatchPage({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('movies')
              .add({'title': controller.text});
          controller.clear();
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('movies').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading');
            }
            final documents = snapshot.data!.docs;
            return ListView(children: [
              for (final document in documents) ...[
                Dismissible(
                    key: ValueKey(
                      document.id,
                    ),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('movies')
                          .doc(document.id)
                          .delete();
                    },
                    child: MovieWidget(document['title'])),
              ],
              TextField(
                controller: controller,
              ),
            ]);
          }),
    );
  }
}

class MovieWidget extends StatelessWidget {
  const MovieWidget(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 243, 177, 198),
      child: Text(title),
    );
  }
}
