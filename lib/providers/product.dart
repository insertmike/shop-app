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

  Future<void> toggleFavoriteStatus() async {
    isFavorite = !isFavorite;
    try {
      final url =
          'https://shop-app-flutter-24a54.firebaseio.com/products/$id.json';
      notifyListeners();
      final res = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
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
  //  Future<void> updateProduct(String id, Product updatedProduct) async {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     try {
  //       final url =
  //           'https://shop-app-flutter-24a54.firebaseio.com/products/$id.json';

  //       await http.patch(url,
  //           body: json.encode({
  //             'title': updatedProduct.title,
  //             'description': updatedProduct.description,
  //             'imageUrl': updatedProduct.imageUrl,
  //             'price': updatedProduct.price,
  //           }));

  //       _items[prodIndex] = updatedProduct;
  //       notifyListeners();
  //     } catch (err) {
  //       print(err);
  //       throw err;
  //     }
  //   } else {
  //     // Err Management
  //   }
  // }
}
