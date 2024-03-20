import "package:flutter/material.dart";
import "package:my_browser/screen/provider/web_provider.dart";
import "package:my_browser/utils/routes/browser_routes.dart";
import "package:provider/provider.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: WebProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: browserRoutes,
      ),
    ),
  );
}
