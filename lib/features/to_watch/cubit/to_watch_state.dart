part of 'to_watch_cubit.dart';

@immutable
class ToWatchState {
  const ToWatchState({
    required this.documents,
    required this.errorMessage,
    required this.isLoading,
  });
  final List<WatchModel> documents;
  final String errorMessage;
  final bool isLoading;
}
