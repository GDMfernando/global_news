import 'package:flutter/material.dart';
import 'package:global_news/utils/main_body.dart';
import '../widgets/search_results.dart';
import '../providers/search_provider.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
        title: 'Search',
        appBarColor: Colors.black,
        backGroundColor: Color.fromARGB(255, 15, 15, 15),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              controller: _searchController,
              onChanged: (query) {
                Provider.of<SearchProvider>(context, listen: false)
                    .searchNews(query);
              },
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey
                ),
                  hintText: 'Search', prefixIcon: Icon(Icons.search, color: Colors.grey,)),
            ),
          ),
          const SearchResultsDisplay(),
        ]));
  }
}
