import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class DiscussionForumPage extends StatelessWidget {
  const DiscussionForumPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageTitle: PageTitles.discussion_forum,
      body: Center(
        child: Text('This is the discussion forum page'),
      ),
    );
  }
}
