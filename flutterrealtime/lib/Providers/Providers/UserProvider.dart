
import 'package:flutter/material.dart';
import 'package:flutterrealtime/Models/User.dart';

class UserProvider extends ChangeNotifier{
  
  late User _currentUser;
  late String _gelenBody;
  late String? _isletme;
  late String? _email;
   late String? _password;
   late String _userDealer;

  User get currentUser => _currentUser;
  String get gelenBody=>_gelenBody;
  String get isletme=>_isletme ?? " ";
  String get email=>_email ?? " ";
 String get password=>_password ?? " ";
 String get userDealer=>_userDealer ?? " ";

 void setLoginUser(User currentUser1){
  _currentUser=currentUser1;
   notifyListeners();

}

void setGelenBody(String gelenBody){
  _gelenBody=gelenBody;
   notifyListeners();
}

void setIsletme(String isletme){
  _isletme=isletme;
   notifyListeners();
}

void setEmail(String email){
  _email=email;
   notifyListeners();
}

void setPassword(String password){
  _password=password;
   notifyListeners();
}

void setUserDealer(String isletme){

  if(isletme == "http://sb.saloonburger.com.tr"){
  _userDealer="sbm000";
  }
  if(isletme == "http://195.87.222.67:8080/easycoProPizzaV-0.0.1"){
  _userDealer="pv000";
  }

  
  
   notifyListeners();
}




}
