import 'package:intl/intl.dart';

class UpcomingModel {
  UpcomingModel({
    required this.title,
    required this.url,
    required this.date,
    required this.id,
  });

  final String title;
  final String url;
  final DateTime date;
  final String id;

  String daysLeft() {
    return date.difference(DateTime.now()).inDays.toString();
  }

  String dateFormatted() {
    return DateFormat.MMMEd().format(date);
  }
}
