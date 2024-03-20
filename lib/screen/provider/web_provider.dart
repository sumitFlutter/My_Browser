import 'package:flutter/cupertino.dart';
import 'package:my_browser/utils/share_helper.dart';

class WebProvider with ChangeNotifier{
  double process=0;
  List <String> bookmarks=[];
  void getProcess(double p)
  {
    process=p;
    notifyListeners();
  }
  Future<void> addBookmark(String bookmark)
  async {
    if(await getBookmark()==null)
      {
        bookmarks=[];
      }
    else{
      bookmarks=(await getBookmark())!;
    }
    bookmarks.add(bookmark);
    saveBookmark(l1: bookmarks);
    bookmarks= (await getBookmark())!;
    notifyListeners();
  }
  Future<void> removeBook(int index)
  async {
    bookmarks.removeAt(index);
    saveBookmark(l1: bookmarks);
    if(await getBookmark()==null)
    {
    bookmarks=[];
    }
    else{
  bookmarks=(await getBookmark())!;
  }
    notifyListeners();
  }
  Future<bool?> checkAddedBookmark(String url)
  async {
   await getBookmark();
    if(bookmarks.isEmpty)
      {
        return false;
      }
    else{
      for(int i=0;i<bookmarks.length;i++)
        {
          if(url==bookmarks[i])
            {
              return true;
            }
        }
    }
    notifyListeners();
  }
  void getBookMark()
  async {
    if(await getBookmark()==null)
    {
    bookmarks=[];
    }
    else{
  bookmarks=(await getBookmark())!;
  }
    notifyListeners();
  }
}