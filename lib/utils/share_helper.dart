import 'package:shared_preferences/shared_preferences.dart';
void saveBookmark({required List <String> l1}) async {
  SharedPreferences s1 = await SharedPreferences.getInstance();
  s1.setStringList("book", l1);
}

Future<List<String>?> getBookmark() async {
  SharedPreferences s1 = await SharedPreferences.getInstance();
  s1.getStringList("book");
  return s1.getStringList("book");
}
