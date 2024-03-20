import 'package:flutter/material.dart';
import 'package:my_browser/utils/connectivity_check.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4),() => Navigator.pushNamed(context, "home"),);
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1),() =>   firstTimeM(context),);
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo/logo.png",height: 120,width: 120,fit: BoxFit.cover,),
            const SizedBox(height: 5,),
            const Text("My Browser"),
          ],),
      ),),);
  }
}
