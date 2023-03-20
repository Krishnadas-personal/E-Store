import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';
import '../widgets/product_list.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/products';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isFavorite = false;

  bool _init = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      final prodId = ModalRoute.of(context)?.settings.arguments as String;
      print(prodId);
      Provider.of<ProductsProvider>(context).productDetails(prodId).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ProductsData = Provider.of<ProductsProvider>(context);
    final products = ProductsData.productsList;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: (_isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    IconButton(
                      icon: (isFavorite)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                    // create:(ctx)=> Product(),
                    // ignore: deprecated_member_use
                    value: products[index],
                    child: ProductsList(),
                  ),
                  itemCount: products.length,
                ),
              )
            ]),
    );
  }
}
