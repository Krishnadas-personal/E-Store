import 'package:carousel_slider/carousel_slider.dart';

import '../models/products.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enlargeFactor: 0.4,
                    ),
                    items: product.images
                        .map((img) => Image.network(img))
                        .toList()),
              ),
              Positioned(
                bottom: 10,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  color: Colors.black54,
                  width: 300,
                  child: Text(
                    product.title,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.branding_watermark),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      product.brand,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.rate_review),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      product.rating.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.attach_money_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      product.price.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.description,
              style: TextStyle(color: Colors.grey[700], fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
