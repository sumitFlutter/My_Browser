import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void connectivityCheck(context) {
   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    showDialog(context: context, builder: (context) {
         return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                result==ConnectivityResult.none?
                const Text("Connect to a network",
                  style: TextStyle(fontWeight: FontWeight.bold),):
                    const Text("You are connected to Network",style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                result==ConnectivityResult.none?
                const Text(
                    "To use Browser, turn on mobile data or\nconnect to Wi-Fi."):
                    Container(),
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
  });
}
void firstTimeM(context) async {
  ConnectivityResult firstTime = await Connectivity().checkConnectivity();
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          firstTime == ConnectivityResult.none ?
          const Text("Connect to a network",
            style: TextStyle(fontWeight: FontWeight.bold),) :
          const Text("You are connected to Network",
            style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          firstTime == ConnectivityResult.none ?
          const Text(
              "To use Browser, turn on mobile data or\nconnect to Wi-Fi.") :
          Container(),
          const Divider(),
          const SizedBox(height: 5,),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(child:
              Text("OK!", style: TextStyle(
                  color: firstTime == ConnectivityResult.none
                      ? Colors.red
                      : Colors.blue),),),
            ],),
          ),
        ],
      ),
    );
  });
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            result == ConnectivityResult.none ?
            const Text("Connect to a network",
              style: TextStyle(fontWeight: FontWeight.bold),) :
            const Text("You are connected to Network",
              style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            result == ConnectivityResult.none ?
            const Text(
                "To use Browser, turn on mobile data or\nconnect to Wi-Fi.") :
            Container(),
            const Divider(),
            const SizedBox(height: 5,),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center, children: [
                Center(child:
                Text("OK!", style: TextStyle(color: Colors.blue),),),
              ],),
            ),
          ],
        ),

      );
    },);
  });
}
