import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/watch_model.dart';

class WatchRepository {
  Stream<List<WatchModel>> getWatchStream() {
    return FirebaseFirestore.instance
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
    await FirebaseFirestore.instance.collection('movies').add(
      {'title': title},
    );
  }

  Future<void> dismiss({required String id}) async {
    await FirebaseFirestore.instance
        .collection(
          'movies',
        )
        .doc(id)
        .delete();
  }
}
