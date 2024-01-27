import 'package:flutter/material.dart';
import 'package:global_news/providers/news_provider.dart';
import 'package:global_news/providers/search_provider.dart';
import 'package:global_news/screens/category_screen.dart';
import 'package:global_news/screens/home.dart';
import 'package:global_news/screens/search.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SearchProvider()),
          ChangeNotifierProvider(create: (context) => NewsProvider()),
        ],
        child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlobalNews',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow.shade800),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/search': (context) => Search(),
        '/category': (context) => CategoryScreen(),
      },
    );
  }
}
