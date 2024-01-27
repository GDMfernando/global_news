import 'package:flutter/material.dart';
import 'package:global_news/utils/main_body.dart';

import '../models/category_model.dart';
import '../services/data.dart';
import '../widgets/category_tile.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      appBarColor: Colors.black,
        backGroundColor: Color.fromARGB(255, 15, 15, 15),
        title: 'Categories',
        body: Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: CategoryTile(
                      image: categories[index].image,
                      categoryName: categories[index].categoryName,
                    ),
                  );
                }),
          ),
        ));
  }
}
