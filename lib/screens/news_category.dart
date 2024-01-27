import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_news/utils/main_body.dart';

import '../models/show_category.dart';
import '../services/show_category_news.dart';
import 'article_view.dart';

class NewsCategory extends StatefulWidget {
  String name;
  NewsCategory({required this.name});

  @override
  State<NewsCategory> createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
        backGroundColor: Color.fromARGB(255, 15, 15, 15),
        title: widget.name,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ShowCategory(
                    Image: categories[index].urlToImage!,
                    desc: categories[index].description!,
                    title: categories[index].title!,
                    url: categories[index].url!
                );
              }),
        ));
  }
}


class ShowCategory extends StatelessWidget {
  String Image, desc, title, url;
  ShowCategory({required this.Image, required this.desc, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: Image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Text(desc, maxLines: 3,
          style: TextStyle(
            color: Colors.grey.shade300
          ),),
          const SizedBox(height: 30.0,),
        ],
      ),
    );
  }
}
