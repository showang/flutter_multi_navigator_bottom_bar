![pub](https://img.shields.io/pub/v/multi_navigator_bottom_bar.svg)

# multi_navigator_bottom_bar

Helps you to build multi-navigator bottom bar easiler.

# Usage

There is an example app in the repo. Part of usage:
```dart
class _MyHomePageState extends State<MyHomePage> {
  static final tabSize = 4;
  final List<GlobalKey<NavigatorState>> navigatorKeys =
      List.generate(tabSize, (index) => GlobalKey<NavigatorState>());
  var currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiNavigatorBottomBar(
        currentTabIndex: currentTabIndex,
        tabs: List.generate(
          tabSize,
          (index) => createTab(navigatorKeys[index], index.toString()),
        ));
  }

  BottomBarTab createTab(GlobalKey<NavigatorState> key, String name) {
    return BottomBarTab(
        navigatorKey: key,
        initPage: Page(name),
        tabIcon: Icon(Icons.add),
        tabTitle: Text("Tab $name"));
  }
}

```

# Use this package as a library
## 1. Depend on it
Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  multi_navigator_bottom_bar: ^0.0.1
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
