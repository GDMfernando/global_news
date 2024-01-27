import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../services/news_data.dart';

class SearchProvider with ChangeNotifier {
  List<ArticleModel> _searchResults = [];
  bool _searching = false;

  List<ArticleModel> get searchResults => _searchResults;
  bool get isSearching => _searching;

  void searchNews(String query) async {
    _searching = true;
    notifyListeners();

    _searchResults.clear();
    News newsClass = News();
    await newsClass.getNews();
    _searchResults = newsClass.news
        .where((article) =>
    article.title!.toLowerCase().contains(query.toLowerCase()) ||
        article.description!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    _searching = false;
    notifyListeners();
  }
}