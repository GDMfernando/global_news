import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import 'blog_tile.dart';

class SearchResultsDisplay extends StatelessWidget {
  const SearchResultsDisplay({Key? key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Consumer<SearchProvider>(
        builder: (context, searchProvider, _) {
          return searchProvider.isSearching
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchProvider.searchResults.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            url: searchProvider.searchResults[index].url!,
                            desc: searchProvider
                                .searchResults[index].description!,
                            imageUrl:
                                searchProvider.searchResults[index].urlToImage!,
                            title: searchProvider.searchResults[index].title!,
                          );
                        },
                      ),
                    ]),
                  ),
                );
        },
      );
    });
  }
}
