![pub](https://img.shields.io/pub/v/multi_navigator_bottom_bar.svg)

# multi_navigator_bottom_bar

Helps you to build multi-navigator bottom navigation bar more easily.

# Usage

There is an example app in the repo. Part of the main scenario:
```dart
class _MyHomePageState extends State<MyHomePage> {
  static final tabSize = 4;
  var currentTabIndex = 0;

  @override
  Widget build(BuildContext context) => MultiNavigatorBottomBar(
      currentTabIndex: currentTabIndex,
      pageWidgetDecorator: pageDecorator,
      tabs: List.generate(
        tabSize,
        (index) => BottomBarTab(
              initPageBuilder: (_) => Page(index.toString()),
              tabIconBuilder: (_) => Icon(Icons.add),
              tabTitleBuilder: (_) => Text("Tab ${index.toString()}"),
            ),
      ));

  Widget pageDecorator(pageWidget) => Column(
        children: <Widget>[
          Expanded(child: pageWidget),
          Container(
            alignment: AlignmentDirectional.center,
            height: 48.0,
            color: Colors.black,
            child: Text(
              "PageWidgetDecorator",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
}
```

# Use this package as a library
## 1. Depend on it
Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  multi_navigator_bottom_bar: ^0.0.3
```

## 2. Install it
You can install packages from the command line:

with pub:

```console
$ pub get
```
with Flutter:

```console
$ flutter packages get
```
Alternatively, your editor might support pub get or flutter packages get. Check the docs for your editor to learn more.

## 3. Import it
Now in your Dart code, you can use:

```dart
import 'package:multi_navigator_bottom_bar/multi_navigator_bottom_bar.dart';
```
