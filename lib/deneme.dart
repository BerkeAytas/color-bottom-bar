import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/app.dart';
import 'package:nested_navigation_demo_flutter/bottom_navigation.dart';
import 'package:nested_navigation_demo_flutter/color_detail_page.dart';
import 'package:nested_navigation_demo_flutter/colors_list_page.dart';
import 'package:nested_navigation_demo_flutter/deneme.dart';
import 'package:nested_navigation_demo_flutter/tab_item.dart';
import 'package:nested_navigation_demo_flutter/tab_navigator.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String deneme = '/deneme';
}

class Deneme extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DenemeState();
}

class DenemeState extends State<Deneme> {
  var _currentTab = TabItem.yellow;
  final _navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.deneme]!(context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, {int materialIndex: 500}) {
    return {TabNavigatorRoutes.deneme: (context) => App()};
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.red) {
            // select 'main' tab
            _selectTab(TabItem.red);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('AlertDialog Title'),
              content: const Text('AlertDialog description'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => routeBuilders[TabNavigatorRoutes.deneme]!(context),
                    ),
                  ),
                  child: const Text('Canasdasdcel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          child: Icon(Icons.add),
        ),
        body: Stack(children: <Widget>[
          Text("data"),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
