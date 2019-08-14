
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';
import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ProductItem(
        title: products[index].title,
        id: products[index].id,
        imageUrl: products[index].imageUrl,
        price: products[index].price,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
