//import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
  String get userId {
    return _userId;
  }
  Future<void> _auth(String email, String password, String urlApiKey) async {
    try {
      final url =
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlApiKey';
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      // Check for error key
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      
      _userId = responseData['localId'];
      
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      
      _autoLogout();
     
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      
      final userData = json.encode({
        'token' : _token,
        'userId' : userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      
      prefs.setString('userData', userData);
     
    } catch (err) {
     
      throw err;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData'))  return false;
    final extractedUserData = json.decode(prefs.getString('userData'));
    final expiryDate =  DateTime.parse(extractedUserData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now()))  return false;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
    
  }

  Future<void> signup(String email, String password) async {
    var urlApiKey = "signUp?key=AIzaSyCA1uP1skoLoFcuutUImcgU23JsNcOxBMY";
    return _auth(email, password, urlApiKey);
    //
  }

  Future<void> signin(String email, String password) async {
    var urlApiKey =
        "signInWithPassword?key=AIzaSyCA1uP1skoLoFcuutUImcgU23JsNcOxBMY";
    return _auth(email, password, urlApiKey);
  }

  void logout() async{
    _token = null;
    _userId = null;
    _expiryDate = null;
    
    if(_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // Clear all data 
    prefs.clear();
  }

  void _autoLogout(){
    if(_authTimer != null) {
      _authTimer.cancel();
    }
    final timeUntilExpiry =_expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeUntilExpiry ), logout);
    
  }
}
