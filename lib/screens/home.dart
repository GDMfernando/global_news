import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:global_news/utils/main_body.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/article_model.dart';
import '../models/slider_model.dart';
import '../providers/news_provider.dart';
import '../widgets/blog_tile.dart';
import 'all_news.dart';
import 'article_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;
  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false).getSlider();
    Provider.of<NewsProvider>(context, listen: false).getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (context, newsProvider, _) {
      return MainBody(
          title: 'GlobalNews',
          appBarColor: Colors.black,
          backGroundColor: Color.fromARGB(255, 15, 15, 15),
          body: newsProvider.loading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Breaking News!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllNews(news: "Breaking")));
                                },
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.yellow.shade800,
                                      color: Colors.yellow.shade800,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        newsProvider.loading2
                            ? Center(child: CircularProgressIndicator())
                            : CarouselSlider.builder(
                                itemCount: newsProvider.sliders.length > 5 ? 5 : newsProvider.sliders.length,
                                itemBuilder: (context, index, realIndex) {
                                  String? res =
                                      newsProvider.sliders[index].urlToImage;
                                  String? res1 =
                                      newsProvider.sliders[index].title;
                                  String? articleUrl = newsProvider.sliders[index].url;
                                  return buildImage(res!, index, res1!, articleUrl!);
                                },
                                options: CarouselOptions(
                                    height: 250,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        activeIndex = index;
                                      });
                                    })),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Center(child: buildIndicator(newsProvider)),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trending News!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllNews(news: "Trending")));
                                },
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.yellow.shade800,
                                      color: Colors.yellow.shade800,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: newsProvider.articles.length,
                              itemBuilder: (context, index) {
                                return BlogTile(
                                    url: newsProvider.articles[index].url!,
                                    desc: newsProvider
                                        .articles[index].description!,
                                    imageUrl: newsProvider
                                        .articles[index].urlToImage!,
                                    title: newsProvider.articles[index].title!);
                              }),
                        )
                      ],
                    ),
                  ),
                ));
    });
  }

  Widget buildImage(String image, int index, String name, String articleUrl) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
          onTap: () {
            // Navigate to article view
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleView(blogUrl: articleUrl),
              ),
            );
          },
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            height: 200,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            imageUrl: image,
          ),
        ),
        Container(
          height: 200,
          padding: EdgeInsets.only(left: 10.0),
          margin: EdgeInsets.only(top: 170.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Center(
            child: Text(
              name,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ])));

  Widget buildIndicator(NewsProvider newsProvider) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: newsProvider.sliders.length > 5 ? 5 : newsProvider.sliders.length,
        effect: WormEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.yellow.shade800),
      );
}
