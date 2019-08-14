import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  //final String title;
  //final int price;
  //ProductDetailScreen(this.title, this.price);
  static const routeName = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: null,
    );
  }
}//