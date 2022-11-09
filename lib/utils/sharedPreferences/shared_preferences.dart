import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

class UserPreferences{

  String _inMemoryToken = '';
  int _cliente = 0;

  //Ojo que cuando leemos algo guardado en la memoria del telefono
// pasa como con la api, es asincrono
  //Devolvernos el token guardado en memoria
  Future<String> get userAccesToken async{
    //1.comprobar si lo tenemos guardado ya en ram
    if(_inMemoryToken.isNotEmpty){
      return _inMemoryToken;
    }
    //2. SI no esta guardado en la variable, lo sacamos de la memoria fisica
    _inMemoryToken = await _loadTokenFromShared();

    return _inMemoryToken;
  }

  //3. Lo traemos desde la memoria fisica del terminal
  Future<String> _loadTokenFromShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var accestoken = '';
    //Comprobar que existe esa varable guardade en memoria fisica
    final token = prefs.getString('token');
    if(token != null){
      accestoken = token;
    }
    return accestoken;
  }

  Future<int> get cliente async{
    if(_cliente != 0){
      return _cliente;
    }

    _cliente = await _loadClienteFromShared();
    return _cliente;
  }

  Future<int> _loadClienteFromShared()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var cliente = 0;
    final clienteId= prefs.getInt('id_cliente');

    if(clienteId != null){
      cliente = clienteId;
    }
    return cliente;
  }

  //Guardarlo en la memoria fisica
    saveUserOnLogin(User user) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('token', user.token!);
      prefs.setInt('id_cliente', user.idCliente!);
      prefs.setInt('id_user', user.id!);
    }


}