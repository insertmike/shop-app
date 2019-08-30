import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    isFavorite = !isFavorite;
    try {
      final url =
          'https://shop-app-flutter-24a54.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
      notifyListeners();
      final res = await http.put(
        url,
        body: json.encode(
          isFavorite
        ),
      );
      if (res.statusCode > 400) {
        isFavorite = !isFavorite;
        notifyListeners();
        throw HttpException('Could not delete product.');
      }
    } catch (err) {
      throw err;
    }
  }
}
