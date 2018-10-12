import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_navigator_bottom_bar/multi_navigator_bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentTabIndex = 0;
  final List<GlobalKey<NavigatorState>> navigatorKeys =
      List.generate(4, (index) => GlobalKey<NavigatorState>());

  @override
  Widget build(BuildContext context) {
    return MultiNavigatorBottomBar(
        currentTabIndex: currentTabIndex,
        tabs: List.generate(
            4, (index) => createTab(navigatorKeys[index], index.toString())));
  }

  BottomBarTab createTab(GlobalKey<NavigatorState> key, String name) {
    return BottomBarTab(
        navigatorKey: key,
        initPage: Page(name),
        tabIcon: Icon(Icons.add),
        tabTitle: Text("Tab $name"));
  }
}

class Page extends StatefulWidget {
  final String name;

  Page(this.name);

  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<Page> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Colors.grey,
          alignment: AlignmentDirectional.center,
          child: FlatButton(
            color: Colors.pinkAccent,
            onPressed: () => Navigator.push(context,
                CupertinoPageRoute(builder: (context) => SubPage(widget.name))),
            child: Text("Page ${widget.name}"),
          ),
        ),
      );
}

class SubPage extends StatefulWidget {
  final String name;

  SubPage(this.name);

  @override
  State<StatefulWidget> createState() => SubPageState();
}

class SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Colors.white,
          alignment: AlignmentDirectional.center,
          child: Text(
            "SubPage: ${widget.name}",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
