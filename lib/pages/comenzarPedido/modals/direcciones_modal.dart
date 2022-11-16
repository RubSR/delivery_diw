import 'package:delivery_diw/pages/comenzarPedido/modals/add_direccion_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../models/Cliente.dart';


class SelecDireccionPage extends StatefulWidget {
  List<Direcciones> direcciones;
   SelecDireccionPage({Key? key, required this.direcciones}) : super(key: key);

  @override
  State<SelecDireccionPage> createState() => _SelecDireccionPageState();
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
            onPressed: (){
              showMaterialModalBottomSheet(
                expand: true,
                  context: context,
                  builder: (context) => AddDireccionModal()


              );

            },
          ),
        ),
        child:SafeArea (
              //Comprobar si mi lista de direcciones esta vacia o no
          // con un ternario
            child:
            widget.direcciones.isEmpty?
            Container(

                margin: const EdgeInsets.symmetric(vertical: 50),
                alignment: Alignment.center,
                child: Column(
                  children:const [
                     Text('No hay direcciones disponibles'),
                  ],
                ))
                :
            ListView.builder(
              //La longitud de la lista
                itemCount: widget.direcciones.length ,
                itemBuilder: (context, int i){
                  return ListTile(
                    onTap: (){
                      Navigator.pop(context,widget.direcciones[i]);
                    },
                     //calle , numer, puerta piso escalera
                    title: Text('${widget.direcciones[i].calle!}, ${widget.direcciones[i].numero!}, ${widget
                    .direcciones[i].puertaPisoEscalera!}'),
                    subtitle: Text('${widget.direcciones[i].provincia!.provincia!}, ${widget
                        .direcciones[i].municipio!.municipio!}, ${widget.direcciones[i].codPostal!} '),
                    // trailing: IconButton(
                    //   icon: const Icon(Icons.add, color: Colors.green),
                    //   onPressed: (){
                    //       Navigator.pop(context,widget.direcciones[i]);
                    //   },
                    // ),
                  );
                }
            )
        ),
        //Pintar las lista de direcciones
      ),
    );
  }
}
