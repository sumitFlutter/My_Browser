import 'package:flutter/cupertino.dart';
import 'package:my_browser/screen/view/bookmark/bookmark_view_screen.dart';
import 'package:my_browser/screen/view/home/home_screen.dart';
import 'package:my_browser/screen/view/splesh/splesh_screen.dart';

Map <String,WidgetBuilder> browserRoutes={
  "/":(context) => const SpleshScreen(),
  "home":(context) => const HomeScreen(),
  "bookmark":(context) => const BookmarkScreen()
};