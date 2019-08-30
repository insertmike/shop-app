//import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
      
      notifyListeners();
      
    } catch (err) {
      throw err;
    }
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
}
