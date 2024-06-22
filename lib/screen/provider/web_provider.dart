import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_browser/utils/connectivity_check.dart';
import 'package:my_browser/utils/share_helper.dart';

class WebProvider with ChangeNotifier{
  double process=0;
  List <String> bookmarks=[];
  bool? isOnline;
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
  void checkOnline()
  {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isOnline=false;
        notifyListeners();
      }
      else if(result==ConnectivityResult.other)
        {
          isOnline=null;
          notifyListeners();
        }
      else{
        isOnline=true;
        notifyListeners();
      }
    });
        }
        Future<void> getOnline()
        async {
          isOnline=await firstTimeM();
          notifyListeners();
        }
        void getNull()
        {
          isOnline=null;
          notifyListeners();
        }
}