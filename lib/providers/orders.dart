import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  // Future<void> addProduct(Product product) async {
  //   const url = 'https://shop-app-flutter-24a54.firebaseio.com/products.json';
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         {

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://shop-app-flutter-24a54.firebaseio.com/orders.json';
    try {
      final timeStamp = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }),
      );
      // Add to the beginning of the list
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timeStamp,
          products: cartProducts,
        ),
      );
    } catch (err) {
      throw err;
    }

    notifyListeners();
  }
}
//           'title': product.title,
//           'description': product.description,
//           'imageUrl': product.imageUrl,
//           'price': product.price,
//           'isFavorite': product.isFavorite,
//         },
//       ),
//     );
//     final newProduct = Product(
//       description: product.description,
//       id: json.decode(response.body)['name'],
//       imageUrl: product.imageUrl,
//       price: product.price,
//       title: product.title,
//     );
//     _items.add(newProduct);
//     notifyListeners();
//   } catch (error) {
//     print(error);
//     throw error;
//   }
// }
