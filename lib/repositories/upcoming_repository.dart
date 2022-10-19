import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/upcoming_model.dart';

class UpcomingReposiroty {
  Stream<List<UpcomingModel>> getUpcomingStream() {
    return FirebaseFirestore.instance
        .collection('upcoming')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UpcomingModel(
          title: doc['title'],
          url: doc['url'],
          date: (doc['date'] as Timestamp).toDate(),
          id: doc.id,
        );
      }).toList();
    });
  }

  Future<void> addUpcoming({
    required String title,
    required String url,
    required DateTime date,
  }) async {
    await FirebaseFirestore.instance.collection('upcoming').add({
      'title': title,
      'url': url,
      'date': date,
    });
  }
}
