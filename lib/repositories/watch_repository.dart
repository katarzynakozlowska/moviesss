import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/watch_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WatchRepository {
  Stream<List<WatchModel>> getWatchStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('movies')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return WatchModel(title: doc['title'], id: doc.id);
      }).toList();
    });
  }

  Future<void> addMovies({
    required String title,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('movies')
        .add(
      {'title': title},
    );
  }

  Future<void> dismiss({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection(
          'movies',
        )
        .doc(id)
        .delete();
  }
}
