import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class SearchResultsPage extends StatefulWidget {
  final String _searchTextValue;

  const SearchResultsPage(this._searchTextValue, {Key key}) : super(key: key);

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: PageTitles.searchResults,
      body: Center(
        child: Text(widget._searchTextValue),
      ),
    );
  }
}
