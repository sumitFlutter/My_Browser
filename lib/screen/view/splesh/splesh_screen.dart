import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/web_provider.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  WebProvider? webR;
  WebProvider? webW;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4),() => context.read<WebProvider>().navigateToHomeScreen(),);
  }

  @override
  Widget build(BuildContext splash) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo/logo.png",
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("My Browser"),
            ],
          ),
        ),
      ),
    );
  }
}
