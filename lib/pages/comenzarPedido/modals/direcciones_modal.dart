import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/Cliente.dart';


class SelecDireccionPage extends StatefulWidget {
  List<Direcciones> direcciones;
   SelecDireccionPage({Key? key, required this.direcciones}) : super(key: key);

  @override
  State<SelecDireccionPage> createState() => _SelecDireccionPageState();
}

class Direccion {
}

class _SelecDireccionPageState extends State<SelecDireccionPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: const SizedBox(),
          middle: const Text('Seleccionar direccion'),
          trailing: TextButton(
            child: const Text('Añadir direccion',
            style: TextStyle(color: Colors.green, fontSize: 10),
            ),
            onPressed: (){},
          ),
        ),
        child:SafeArea (

            child: Container(

                margin: EdgeInsets.symmetric(vertical: 50),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text('No hay direcciones disponibles'),
                  ],
                ))),
        //Pintar las lista de direcciones
      ),
    );
  }
}
