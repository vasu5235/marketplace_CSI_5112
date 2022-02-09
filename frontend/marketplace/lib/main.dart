import 'package:flutter/material.dart';
import 'package:marketplace/pages/cart_page.dart';
import 'package:marketplace/pages/discussion_forum_page.dart';

import 'constants/constants.dart' as Constants;
import 'constants/route_names.dart';
import 'pages/my_account_page.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/orders_page.dart';
import 'widgets/app_route_observer.dart';

void main() => runApp(MarketPlace());

class MarketPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.APP_NAME,
      theme: ThemeData(
        primarySwatch: Constants.APP_BAR_COLOR,
        highlightColor: Colors.black.withOpacity(0.5),
        pageTransitionsTheme: PageTransitionsTheme(
          // makes all platforms that can run Flutter apps display routes without any animation
          builders: Map<TargetPlatform,
                  _InanimatePageTransitionsBuilder>.fromIterable(
              TargetPlatform.values.toList(),
              key: (dynamic k) => k,
              value: (dynamic _) => const _InanimatePageTransitionsBuilder()),
        ),
      ),
      initialRoute: RouteNames.home,
      navigatorObservers: [AppRouteObserver()],
      routes: {
        RouteNames.home: (_) => const HomePage(),
        RouteNames.myAccount: (_) => const MyAccountPage(),
        RouteNames.orders: (_) => const OrdersPage(),
        RouteNames.cart: (_) => const CartPage(),
        RouteNames.discussion_forum: (_) => const DiscussionForumPage(),
        RouteNames.settings: (_) => const SettingsPage()
      },
    );
  }
}

/// This class is used to build page transitions that don't have any animation
class _InanimatePageTransitionsBuilder extends PageTransitionsBuilder {
  const _InanimatePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}
