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
  TextEditingController webTxt=TextEditingController();
  @override
  Widget build(BuildContext context) {
    webR=context.read<WebProvider>();
    webW=context.watch<WebProvider>();
    Future.delayed(const Duration(seconds: 1),() => connectivityCheck(context));
    return SafeArea(child: Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: () {
        inAppWebViewController?.loadUrl(urlRequest:  URLRequest(url: WebUri("https://www.google.com/")));
        webTxt.clear();
      },icon: Icon(Icons.home),),
       centerTitle: true,
       title: TextField(controller: webTxt,
       onSubmitted: (value) {
         inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: WebUri("https://www.google.com/search?q=${webTxt.text}")));
         webTxt.clear();
       },
       decoration: InputDecoration(
       hintText: "Search AnyThing....",suffixIcon: IconButton(icon: Icon(Icons.search_rounded),onPressed: () {
       inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: WebUri("https://www.google.com/search?q=${webTxt.text}")));
       webTxt.clear();
       },)),),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [PopupMenuItem(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () async{
                String url=(await inAppWebViewController!.getUrl()).toString();
               bool? check= webR!.checkAddedBookmark(url);
               if(check==true)
                 {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already Added")));
                 }
               else{
                 webR!.addBookmark(url);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added")));
               }

              }, icon: Icon(Icons.bookmark_add)),
              IconButton(onPressed: () async{
                bool? back=await inAppWebViewController?.canGoBack();
                back==true?
                inAppWebViewController?.goBack():
                    inAppWebViewController?.reload();
              }, icon: Icon(Icons.arrow_back_ios_new)),
              IconButton(onPressed: () {
                inAppWebViewController?.reload();
              }, icon: Icon(Icons.refresh)),
              IconButton(onPressed: () async{
                bool? goAhead=await inAppWebViewController?.canGoForward();
                goAhead==true?
                inAppWebViewController?.goForward():
                    inAppWebViewController?.reload();
              }, icon: Icon(Icons.arrow_forward_ios))
            ],),),
          PopupMenuItem(onTap: () {
            Navigator.pushNamed(context, "bookmark");
          },
              child: Row(children: [
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
            },
            onReceivedError:(controller, request, error) {
              inAppWebViewController=controller;
            },
              onLoadStart: (controller, url) {
                inAppWebViewController=controller;
              },
              onLoadStop: (controller, url) {
                inAppWebViewController=controller;
              },
            ),
          ),
        ],
      ),
    ));
  }
}
