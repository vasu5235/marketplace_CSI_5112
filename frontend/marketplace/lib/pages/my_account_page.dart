import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageTitle: PageTitles.myAccount,
      body: Center(
        child: Text('This is the my-accounts page'),
      ),
    );
  }
}
