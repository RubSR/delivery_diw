import 'dart:convert';

import 'package:delivery_diw/utils/bse_url.dart';
import 'package:http/http.dart';

import '../../../models/api_reponse.dart';

class RegistroService{



  Future<ApiResponse> registroUser(Map<String,dynamic> cliente) async{
      ApiResponse _apiResponse = ApiResponse();
    //Dentro del post hay que pasar varias cosas
      //1. la url del endpoint al que queremos atacar->parseardo de URI
      //2. El json que queremos enviar que lo codificaremos a partir del map
      //3. HEaders que son las cabeceras que entre cosas indican que tipo
      // de contenido maneja la peticion -> json
      Response res = await post(Uri.parse('${baseUrl}user/'),
        body: json.encode(cliente),
        headers: {
        'Content-Type': 'application/json'
        }
        );
      print(res.body);
      if(res.statusCode == 200){
        _apiResponse.error = false;
      }
      //Aqui no estoy controlando los codigos de error
      //Deberias controlarlos
      else{
        _apiResponse.error = true;
        _apiResponse.apiErrorMessage = 'Error, intentelo mas tarde';
      }

      return _apiResponse;

  }

}