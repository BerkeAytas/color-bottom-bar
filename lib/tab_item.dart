import 'package:flutter/material.dart';

enum TabItem { red, green, blue, yellow }

const Map<TabItem, String> tabName = {
  TabItem.red: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
  TabItem.yellow: 'blue',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.red: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
  TabItem.yellow: Colors.yellow,
};
