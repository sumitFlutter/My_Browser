import 'package:flutter/material.dart';
import 'package:my_browser/screen/provider/web_provider.dart';
import 'package:my_browser/screen/view/home/home_screen.dart';
import 'package:my_browser/screen/view/splesh/splesh_screen.dart';
import 'package:my_browser/utils/connectivity_check.dart';
import 'package:provider/provider.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  List<Widget> screen=[const SpleshScreen(),const HomeScreen()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1),() {
      internetCheck(context);
    },);
  }
  @override
  Widget build(BuildContext dash) {
    return SafeArea(child: Scaffold(
      body: screen[context.watch<WebProvider>().screenIndex],
    ));
  }
}
