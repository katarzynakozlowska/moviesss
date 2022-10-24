import 'package:curlzzz_new/data_source/remote_watch_data_source.dart';
import 'package:curlzzz_new/models/watch_model.dart';

class WatchRepository {
  WatchRepository(this._remoteDataSource);
  final RemoteWatchDataSource _remoteDataSource;

  Stream<List<WatchModel>> getWatchStream() {
    return _remoteDataSource.getRemoteWatchStream().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return WatchModel(title: doc['title'], id: doc.id);
      }).toList();
    });
  }

  Future<void> addMovies({
    required String title,
  }) {
    return _remoteDataSource.addRemoteWatchData(title: title);
  }

  Future<void> dismiss({required String id}) {
    return _remoteDataSource.dismissRemoteData(id: id);
  }
}
