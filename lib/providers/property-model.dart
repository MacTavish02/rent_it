import 'package:flutter/foundation.dart';

class Property {
  final String id;
  final String title;
  final int price;
  final double rating;
  final String imageUrl;
  final bool isFavorite;

  Property({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.rating,
    @required this.imageUrl,
    @required this.isFavorite,
  });
}
