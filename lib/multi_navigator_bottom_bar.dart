library multi_navigator_bottom_bar;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBarTab {
  final WidgetBuilder routePageBuilder;
  final Widget initPage;
  final WidgetBuilder tabIconBuilder;
  final WidgetBuilder tabTitleBuilder;
  final GlobalKey<NavigatorState> _navigatorKey;

  BottomBarTab({
    @required this.initPage,
    @required this.tabIconBuilder,
    this.tabTitleBuilder,
    this.routePageBuilder,
    GlobalKey<NavigatorState> navigatorKey,
  }) : _navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
}

class MultiNavigatorBottomBar extends StatefulWidget {
  final int initTabIndex;
  final List<BottomBarTab> tabs;
  final PageRoute pageRoute;
  final ValueChanged<int> onTap;
  final Widget Function(Widget) pageWidgetDecorator;
  final BottomNavigationBarType type;
  final Color fixedColor;
  final double iconSize;

  MultiNavigatorBottomBar({
    @required this.initTabIndex,
    @required this.tabs,
    this.onTap,
    this.pageRoute,
    this.pageWidgetDecorator,
    this.type,
    this.fixedColor,
    this.iconSize = 24.0,
  });

  @override
  State<StatefulWidget> createState() =>
      _MultiNavigatorBottomBarState(initTabIndex);
}

class _MultiNavigatorBottomBarState extends State<MultiNavigatorBottomBar> {
  int currentIndex;

  _MultiNavigatorBottomBarState(this.currentIndex);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => !await widget
            .tabs[currentIndex]._navigatorKey.currentState
            .maybePop(),
        child: Scaffold(
          body: widget.pageWidgetDecorator == null
              ? _buildPageBody()
              : widget.pageWidgetDecorator(_buildPageBody()),
          bottomNavigationBar: _buildBottomBar(),
        ),
      );

  Widget _buildPageBody() => Stack(
        children:
            widget.tabs.map((tab) => _buildOffstageNavigator(tab)).toList(),
      );

  Widget _buildOffstageNavigator(BottomBarTab tab) => Offstage(
        offstage: widget.tabs.indexOf(tab) != currentIndex,
        child: TabPageNavigator(
          navigatorKey: tab._navigatorKey,
          initPage: tab.initPage,
          pageRoute: widget.pageRoute,
        ),
      );

  Widget _buildBottomBar() => BottomNavigationBar(
        type: widget.type,
        fixedColor: widget.fixedColor,
        items: widget.tabs
            .map((tab) => BottomNavigationBarItem(
                  icon: tab.tabIconBuilder(context),
                  title: tab.tabTitleBuilder(context),
                ))
            .toList(),
        onTap: (index) {
          if (widget.onTap != null) widget.onTap(index);
          setState(() => currentIndex = index);
        },
        currentIndex: currentIndex,
      );
}

class TabPageNavigator extends StatelessWidget {
  TabPageNavigator(
      {@required this.navigatorKey, @required this.initPage, this.pageRoute});

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget initPage;
  final PageRoute pageRoute;

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) =>
            pageRoute ??
            MaterialPageRoute(
              builder: (context) =>
                  _defaultPageRouteBuilder(routeSettings.name)(context),
            ),
      );

  WidgetBuilder _defaultPageRouteBuilder(String routName, {String heroTag}) =>
      (context) => initPage;
}
