class ReviewsModel {
  ReviewsModel({
    required this.title,
    required this.rating,
    required this.id,
  });

  final String title;
  // ignore: prefer_typing_uninitialized_variables
  var rating;
  final String id;
}
