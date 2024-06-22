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
    Future.delayed(Duration(seconds: 4),() => Navigator.pushReplacementNamed(context,"home"),);
    context.read<WebProvider>().getOnline();
    Future.delayed(Duration(seconds: 1),() {
      if(context.read<WebProvider>().isOnline==false)
      {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Connect to a network",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                const Text(
                    "To use Browser, turn on mobile data or\nconnect to Wi-Fi."),
                const Divider(),
                const SizedBox(height: 5,),
                InkWell(
                  onTap: () {
                    context.read<WebProvider>().getNull();
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center, children: [
                    Center(child:
                    Text("OK!",style: TextStyle(color: Colors.blue),),),
                  ],),
                ),
              ],
            ),

          );
        },);
      }
      else if(context.read<WebProvider>().isOnline==true)
      {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You Are Connected To Network.")));
        context.read<WebProvider>().getNull();
      }
      else {
        }
      },);
  }

  @override
  Widget build(BuildContext context) {
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
