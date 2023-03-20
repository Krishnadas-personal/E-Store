import 'package:e_store/provider/category_provider.dart';
import 'package:e_store/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: FutureBuilder(
          future: Provider.of<CategoryProvider>(context, listen: false)
              .categoryFetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.error != null) {
              return const Center(
                child: Text("An error occured contact admin"),
              );
            } else {
              return Consumer<CategoryProvider>(
                  builder: (context, category, child) {
                return Categories(category: category.categoryItems);
              });
            }
          },
        ));
  }
  
}
