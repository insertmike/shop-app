import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProds(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<Products>(context);
    print('rebuilding...');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
            )
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _refreshProds(context),
          builder: (ctx, snapShot) =>
              snapShot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProds(context),
                      child: Consumer<Products>(
                        builder: (ctx, productsData, _) => Padding(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                            itemCount: productsData.items.length,
                            itemBuilder: (ctx, index) => Column(
                              children: <Widget>[
                                UserProductItem(
                                  id: productsData.items[index].id,
                                  imageUrl: productsData.items[index].imageUrl,
                                  title: productsData.items[index].title,
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
