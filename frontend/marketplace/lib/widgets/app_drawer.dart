import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import '../constants/page_titles.dart';
import '../constants/route_names.dart';
import 'app_route_observer.dart';

/// The navigation drawer for the app.
/// This listens to changes in the route to update which page is currently been shown
class AppDrawer extends StatefulWidget {
  const AppDrawer({@required this.permanentlyDisplay, Key key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with RouteAware {
  String _selectedRoute;
  AppRouteObserver _routeObserver;

  var session = FlutterSession();
  var _userName = "User";
  var _userEmail = "user@uottawa.ca";
  var _userIsMerchant = false;

  Future<dynamic> _loadSession() async {
    _userName = await session.get("user_name");
    _userEmail = await session.get("user_email");
    _userIsMerchant = await session.get("user_is_merchant");

    if (_userName == null || _userEmail == null) {
      _userName = "User";
      _userEmail = "user@uotttawa.ca";
      _userIsMerchant = false;
    }
    print("_loadSession called isMerchant? = " + _userIsMerchant.toString());
  }

  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _updateSelectedRoute();
  }

  @override
  void didPop() {
    _updateSelectedRoute();
  }

  // Left side Navigation Drawers with all page routing configured in ListTiles
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadSession(),
        builder: (context, snapshot) {
          return Drawer(
            child: Row(
              children: [
                Expanded(
                  child: Builder(builder: (context) {
                    if (_userIsMerchant)
                      return ListView(
                        // padding: EdgeInsets.only(top: 55),
                        children: [
                          UserAccountsDrawerHeader(
                            accountName: Text(_userName),
                            accountEmail: Text(_userEmail),
                            currentAccountPicture: CircleAvatar(
                              child: Icon(Icons.android),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.home),
                            title: const Text(PageTitles.home),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.home);
                            },
                            selected: _selectedRoute == RouteNames.home,
                          ),
                          ListTile(
                            leading: const Icon(Icons.change_circle),
                            title: const Text(PageTitles.mAddProduct),
                            onTap: () async {
                              await _navigateTo(
                                  context, RouteNames.mAddProduct);
                            },
                            selected: _selectedRoute == RouteNames.mAddProduct,
                          ),
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text(PageTitles.mEditProduct),
                            onTap: () async {
                              await _navigateTo(
                                  context, RouteNames.mEditProduct);
                            },
                            selected: _selectedRoute == RouteNames.mEditProduct,
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.chat),
                            title: const Text(PageTitles.discussion_forum),
                            onTap: () async {
                              await _navigateTo(
                                  context, RouteNames.discussion_forum);
                            },
                            selected:
                                _selectedRoute == RouteNames.discussion_forum,
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text(PageTitles.logout),
                            onTap: () async {
                              //ToDo: display alert and reset session variables
                              await _navigateTo(context, RouteNames.settings);
                            },
                            selected: _selectedRoute == RouteNames.settings,
                          ),
                        ],
                      );
                    else
                      return ListView(
                        // padding: EdgeInsets.only(top: 55),
                        children: [
                          UserAccountsDrawerHeader(
                            accountName: Text(_userName),
                            accountEmail: Text(_userEmail),
                            currentAccountPicture: CircleAvatar(
                              child: Icon(Icons.android),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.home),
                            title: const Text(PageTitles.home),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.home);
                            },
                            selected: _selectedRoute == RouteNames.home,
                          ),
                          ListTile(
                            leading: const Icon(Icons.list),
                            title: const Text(PageTitles.orders),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.orders);
                            },
                            selected: _selectedRoute == RouteNames.orders,
                          ),
                          ListTile(
                            leading: const Icon(Icons.shopping_cart),
                            title: const Text(PageTitles.cart),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.cart);
                            },
                            selected: _selectedRoute == RouteNames.cart,
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.chat),
                            title: const Text(PageTitles.discussion_forum),
                            onTap: () async {
                              await _navigateTo(
                                  context, RouteNames.discussion_forum);
                            },
                            selected:
                                _selectedRoute == RouteNames.discussion_forum,
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text(PageTitles.logout),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.settings);
                            },
                            selected: _selectedRoute == RouteNames.settings,
                          ),
                        ],
                      );
                  }),
                ),
                if (widget.permanentlyDisplay)
                  const VerticalDivider(
                    width: 1,
                  )
              ],
            ),
          );
        });
  }

  /// Closes the drawer if applicable (which is only when it's not been displayed permanently) and navigates to the specified route
  /// In a mobile layout, the a modal drawer is used so we need to explicitly close it when the user selects a page to display
  Future<void> _navigateTo(BuildContext context, String routeName) async {
    if (widget.permanentlyDisplay) {
      Navigator.pop(context);
    }
    await Navigator.pushNamed(context, routeName);
  }

  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context).settings.name;
    });
  }
}
