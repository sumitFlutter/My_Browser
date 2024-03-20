import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/web_provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  WebProvider? webR;
  WebProvider? webW;
  @override
  Widget build(BuildContext context) {
    webR=context.read<WebProvider>();
    webW=context.watch<WebProvider>();
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("My Bookmarks"),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("On long press you can remove bookmarks"),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text("Are You Sure?"),
                        actions: [
                          ElevatedButton(onPressed: () {
                            webR!.removeBook(index);
                          }, child: Text("Yes!")),
                          ElevatedButton(onPressed: () {
                                  Navigator.pop(context);
                          }, child: Text("No!"))
                        ],
                      );
                    },);
                  },
                  child: Container(decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Text(webW!.bookmarks[index])),
                  margin: EdgeInsets.all(10),),
                );
              },itemCount: webW!.bookmarks.length,),
            )
          ],
        ),
      ),
    ));
  }
}
