import 'dart:convert';

import 'package:delivery_diw/models/api_reponse.dart';
import 'package:delivery_diw/models/user.dart';
import 'package:delivery_diw/utils/bse_url.dart';
import 'package:delivery_diw/utils/sharedPreferences/shared_preferences.dart';
import 'package:http/http.dart';

class LoginService{


  Future<ApiResponse> loginUser(Map<String, dynamic> user) async{

    ApiResponse _apiresponse = ApiResponse();

    Response res = await post(
      Uri.parse(baseUrl +'login_check'),
      body: json.encode(user),
      headers: {'Content-Type': 'application/json'}
    );
    if(res.statusCode ==200){

      _apiresponse.error= false;
      //Guardar en shared preferences los datos para poder usarlos mas tarde.
      UserPreferences prefs = UserPreferences();
      //json.decode parsea de json a map
      prefs.saveUserOnLogin(User.fromJson(json.decode(res.body)));
    }else{
      _apiresponse.error = true;
      _apiresponse.apiErrorMessage = 'Error de credenciales';
    }
    return _apiresponse;


  }
}