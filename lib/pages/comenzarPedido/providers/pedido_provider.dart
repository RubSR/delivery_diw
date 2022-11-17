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
      //Solo recibo un cliente
      return Cliente.fromJson(json.decode(res.body));
    }else{
      throw Exception('Error al traer el cliente');
    }
  }

  //Metodo que le pide a la api el listado de provincias
  Future<List<Provincia>> getProvincias() async{
    List<Provincia> provincias = [];

    String token = await UserPreferences().userAccesToken;
    Response res = await get(Uri.parse('${baseUrl}provincias'),
      headers: {
      'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );
    if(res.statusCode == 200){
      //lista de pronvicias -> [{}]
      //Primero pasamos a map ->lista maps -> maps a objetos
      List<dynamic> lista = json.decode(res.body); // List<Map>
      //Recorrer esa lista y pasar cada objeto que hay dentro (mapas)
      // y pasar uno por uno ese map a Objeto
      provincias = lista.map((e) => Provincia.fromJson(e)).toList();
      return provincias;
    }
    throw Exception('Error al traer las provincias');
  }
  
  Future<List<Municipio>> getMunicipios(int id) async{
    List<Municipio> municipios = [];
    String token = await userPreferences.userAccesToken;
    
    Response res = await get(Uri.parse('${baseUrl}provincias/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }
        );
    if(res.statusCode == 200){
      //1. pasamos de array de json a List de map
      List<dynamic> jsonList = json.decode(res.body);
      //2.Recorremos la lista de map y pasamos cada map a objeto
      municipios = jsonList.map((e) => Municipio.fromJson(e)).toList();
      return municipios;

    }
    throw Exception('Error al traer los municipios');
    
  }
}