import 'dart:convert';

import 'package:delivery_diw/utils/bse_url.dart';
import 'package:delivery_diw/utils/sharedPreferences/shared_preferences.dart';
import 'package:http/http.dart';

import '../../../models/Cliente.dart';

class PedidoService{

  //Vamos a llamar a la api para que me traiga los datos del cliente
  //1. Necesito el id del cliente ->Guardado en sharedPreferences(en la memoria
  // fisica del telefono)
  UserPreferences userPreferences = UserPreferences();
  //2. Llamamos a Get Cliente
  Future<Cliente> getCliente() async{
    //Necesitamos el token
    String token = await userPreferences.userAccesToken;
    int idCliente = await userPreferences.cliente;
    Response res = await get(Uri.parse('${baseUrl}cliente/$idCliente'),
        headers: {
              'Content-Type':'application/json',
              'Authorization' :'Bearer ${token}'
        }
        );
    if(res.statusCode == 200){
      //1 Pasa de json a map y de map a Cliente
      return Cliente.fromJson(json.decode(res.body));
    }else{
      throw Exception('Error al traer el cliente');
    }
  }
}