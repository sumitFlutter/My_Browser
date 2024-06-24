import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:my_browser/screen/provider/web_provider.dart';
import 'package:my_browser/utils/connectivity_check.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebProvider? webR;
  WebProvider? webW;
  InAppWebViewController ? inAppWebViewController;
  PullToRefreshController? pull;
  TextEditingController webTxt=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        pull=PullToRefreshController(
        onRefresh: (){
          inAppWebViewController?.reload();
        }
    );
  }
  @override
  Widget build(BuildContext home) {
    webR=home.read<WebProvider>();
    webW=home.watch<WebProvider>();
    return SafeArea(child: Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: () {
        inAppWebViewController?.loadUrl(urlRequest:  URLRequest(url: WebUri("https://www.google.com/")));
        webTxt.clear();
      },icon: const Icon(Icons.home),),
       centerTitle: true,
       title: TextField(controller: webTxt,
       onSubmitted: (value) {
         inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: WebUri("https://www.google.com/search?q=${webTxt.text}")));
         webTxt.clear();
       },
       decoration: InputDecoration(
       hintText: "Search AnyThing....",suffixIcon: IconButton(icon: const Icon(Icons.search_rounded),onPressed: () {
       inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: WebUri("https://www.google.com/search?q=${webTxt.text}")));
       webTxt.clear();
       },)),),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [PopupMenuItem(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () async{
                String url=(await inAppWebViewController!.getUrl()).toString();
               bool? check= await webR!.checkAddedBookmark(url);
               if(check==true)
                 {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already Added")));
                 }
               else{
                 webR!.addBookmark(url);
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added")));
               }

              }, icon: const Icon(Icons.bookmark_add)),
              IconButton(onPressed: () async{
                bool? back=await inAppWebViewController?.canGoBack();
                back==true?
                inAppWebViewController?.goBack():
                    inAppWebViewController?.reload();
              }, icon: const Icon(Icons.arrow_back_ios_new)),
              IconButton(onPressed: () {
                inAppWebViewController?.reload();
              }, icon: const Icon(Icons.refresh)),
              IconButton(onPressed: () async{
                bool? goAhead=await inAppWebViewController?.canGoForward();
                goAhead==true?
                inAppWebViewController?.goForward():
                    inAppWebViewController?.reload();
              }, icon: const Icon(Icons.arrow_forward_ios))
            ],),),
          PopupMenuItem(onTap: () {
             webR!.getBookMark();
            showBookmark();
          },
              child: const Row(children: [
            Icon(Icons.bookmark),
            SizedBox(width: 3,),
            Text("bookmarks"),
          ],)),
          ];})]
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: webW!.process,
          ),
          Expanded(
            child: InAppWebView(initialUrlRequest: URLRequest(url: WebUri("https://www.google.com/")),
            onProgressChanged: (controller, progress) {
              inAppWebViewController=controller;
              webR!.getProcess(progress/100);
              if(progress==100)
                {
                  pull!.endRefreshing();
                }
            },
            onReceivedError:(controller, request, error) {
              inAppWebViewController=controller;
            },
              onLoadStart: (controller, url) {
                inAppWebViewController=controller;
              },
              onLoadStop: (controller, url) {
              pull!.endRefreshing();
                inAppWebViewController=controller;
              },
              pullToRefreshController: pull,
            ),
          ),
        ],
      ),
    ));
  }
  void showBookmark()
  {
    showModalBottomSheet(context: context, builder: (context) {
      return  Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text("On long press you can remove bookmarks"),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(webW!.bookmarks[index])));
                    Navigator.pop(context);
                  },
                  onLongPress: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: const Text("Are You Sure?"),
                        actions: [
                          ElevatedButton(onPressed: () {
                            webR!.removeBook(index);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            webR!.getBookMark();
                          }, child: const Text("Yes!")),
                          ElevatedButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: const Text("No!"))
                        ],
                      );
                    },);
                  },
                  child: Container(decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text(webW!.bookmarks[index])),
                    margin: const EdgeInsets.all(10),),
                );
              },itemCount: webW!.bookmarks.length,),
            )
          ],
        ),
      );
    },);
  }
}
