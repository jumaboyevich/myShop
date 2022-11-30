import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
   String _token='';
   DateTime? _expiryDate;
   String _userId='';
    Timer? _authTimer;

  bool get isAuth {
    return _token != '';
  }

  String get token {
    if (_token != '' && _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return '';
  }

  String get userId{
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyC4MQxWGX1SSMyeOJGYNqau7az8YNP_w84';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token=responseData['idToken'];
      _userId=responseData['localId'];
      _expiryDate=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
      final pref=await SharedPreferences.getInstance();
      pref.setString('userData', json.encode(
        {
         'token':_token,
         'userId':_userId,
         'expiryData':_expiryDate,
        }
      ));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async{
  _userId='';
  _token='';
  _expiryDate=null;
  if(_authTimer !=null){
    _authTimer!.cancel();
    _authTimer=null;
  }
  final prefs= await SharedPreferences.getInstance();
  prefs.clear();
  notifyListeners();
  }

  void _autoLogout(){
    if(_authTimer!=null){
      _authTimer!.cancel();
    }

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer= Timer(Duration(seconds: timeToExpiry), logout);
  }
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'accounts:signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'accounts:signInWithPassword');
  }

  Future<bool> tryAutoLogin() async{
    final prefs=await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){
      return false;
    }
    final extractedUserData=json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate=DateTime.parse(extractedUserData['expiryData']);

    if(expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token=extractedUserData['token'];
    _userId=extractedUserData['userId'];
    _expiryDate=expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }
}
