import 'package:flutter/material.dart';

class Menu {
  String title;
  IconData icon;

  Menu({this.title, this.icon});
}

List<Menu> menuItems = [
  Menu(title: 'Class Overview', icon: Icons.dashboard),
  Menu(title: 'Reply Activity', icon: Icons.screen_search_desktop),
  Menu(title: 'Collaboraation Challengw', icon: Icons.group),
  Menu(title: 'Dashbaord challeges', icon: Icons.pages_sharp),
  Menu(title: 'Dashbaord challedges', icon: Icons.comment),
];
