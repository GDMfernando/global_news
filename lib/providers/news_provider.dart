import 'package:flutter/material.dart';
import '../models/slider_model.dart';
import '../models/article_model.dart';
import '../services/news_data.dart';
import '../services/slider_data.dart';

class NewsProvider with ChangeNotifier {
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true,
      _loading2 = true;

  bool get loading => _loading;

  bool get loading2 => _loading2;

  Future<void> getNews() async {
    try {
      News newsclass = News();
      await newsclass.getNews();
      articles = newsclass.news;
      _loading = false;
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> getSlider() async {
    try {
      Sliders slider = Sliders();
      await slider.getSlider();
      sliders = slider.sliders;
      _loading2 = false;
    } catch (e) {
      print('Error fetching sliders: $e');
    } finally {
      notifyListeners();
    }
  }
}
