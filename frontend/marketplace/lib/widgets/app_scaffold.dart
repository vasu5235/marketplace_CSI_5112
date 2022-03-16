import 'package:flutter/material.dart';
import 'package:appbar_textfield/appbar_textfield.dart';
import 'package:marketplace/constants/route_names.dart';
import 'package:marketplace/pages/search_results_page.dart';

import 'app_drawer.dart';

/// A responsive scaffold with navbar, drawer and main area for our application.
/// Displays the navigation drawer alongside the [Scaffold] if the screen/window size is large enough
class AppScaffold extends StatefulWidget {
  const AppScaffold({@required this.body, @required this.pageTitle, Key key})
      : super(key: key);

  final Widget body;

  final String pageTitle;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 900;
    return Row(
      children: [
        if (!displayMobileLayout)
          const AppDrawer(
            permanentlyDisplay: true,
          ),
        Expanded(
          child: Scaffold(
            // appBar: AppBar(
            //   // when the app isn't displaying the mobile version of app, hide the menu button that is used to open the navigation drawer
            //   automaticallyImplyLeading: displayMobileLayout,
            //   title: Text(widget.pageTitle),
            //   actions: <Widget>[
            //     new IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            //     new IconButton(
            //         onPressed: () {}, icon: Icon(Icons.shopping_cart))
            //   ],
            // ),
            appBar: AppBarTextField(
              automaticallyImplyLeading: displayMobileLayout,
              title: Text(widget.pageTitle),
              onBackPressed: _onRestoreAllData,
              onClearPressed: _onRestoreAllData,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
              defaultHintText: "Search Products",
              trailingActionButtons: <Widget>[
                new IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.cart);
                    },
                    icon: Icon(Icons.shopping_cart))
              ],
            ),
            drawer: displayMobileLayout
                ? const AppDrawer(
                    permanentlyDisplay: false,
                  )
                : null,
            body: widget.body,
          ),
        )
      ],
    );
  }

  void _onSearchChanged(String value) {}

  void _onRestoreAllData() {}

  void _onSearchSubmitted(String value) {
    //navigator.push -> new page and display products
    if (value.isEmpty) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(value),
        ));
  }
}
