import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';


void firstTimeM(context) async {
  ConnectivityResult firstTime = await Connectivity().checkConnectivity();
  if(firstTime==ConnectivityResult.none)
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
  else{
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You Are Connected To Network.")));
  }
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if(result==ConnectivityResult.none)
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
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You Are Connected To Network.")));
    }
  });
}
