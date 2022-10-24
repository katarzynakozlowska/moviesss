import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/data_source/remote_upcoming_data_source.dart';
import 'package:curlzzz_new/models/upcoming_model.dart';

class UpcomingReposiroty {
  UpcomingReposiroty(this._upcomingRemoteDataSource);
  final UpcomingRemoteDataSource _upcomingRemoteDataSource;

  Stream<List<UpcomingModel>> getUpcomingStream() {
    return _upcomingRemoteDataSource
        .getUpcomingRemoteData()
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
    await _upcomingRemoteDataSource.addUpcomingRemoteData(
        title: title, url: url, date: date);
  }

  Future<void> deleteUpcoming({required String id}) async {
    await _upcomingRemoteDataSource.deleteUpcomingRemoteData(id: id);
  }
}
