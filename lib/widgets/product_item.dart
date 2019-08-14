import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  ProductItem({this.id, this.title, this.imageUrl, this.price});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.routeName, arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                //    textAlign: TextAlign.center,
              ),
              Text(
                '\$${price.toString()}',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                //  textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
