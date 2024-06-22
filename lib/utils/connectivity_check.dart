import 'package:connectivity_plus/connectivity_plus.dart';


Future<bool?> firstTimeM() async {
  ConnectivityResult firstTime = await Connectivity().checkConnectivity();
  if(firstTime==ConnectivityResult.none)
    {
      return false;}
  else{
    return true;
  }
}
