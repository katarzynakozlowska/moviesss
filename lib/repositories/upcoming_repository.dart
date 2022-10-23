import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/models/upcoming_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpcomingReposiroty {
  Stream<List<UpcomingModel>> getUpcomingStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('upcoming')
        .orderBy('date', descending: false)
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
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('upcoming')
        .add({
      'title': title,
      'url': url,
      'date': date,
    });
  }
}
