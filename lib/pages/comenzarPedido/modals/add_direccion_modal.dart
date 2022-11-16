import 'package:delivery_diw/pages/comenzarPedido/providers/pedido_provider.dart';
import 'package:delivery_diw/utils/colors/colors.dart';
import 'package:delivery_diw/widgets/input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/Cliente.dart';



class AddDireccionModal extends StatefulWidget {
  const AddDireccionModal({Key? key}) : super(key: key);

  @override
  State<AddDireccionModal> createState() => _AddDireccionModalState();
}

class _AddDireccionModalState extends State<AddDireccionModal> {
  //Tantos controllers como inputs tengamos
  TextEditingController calleCtrl = TextEditingController();
  TextEditingController numeroCtrl = TextEditingController();
  TextEditingController puertaCtrl = TextEditingController();
  TextEditingController codPostalCtrl = TextEditingController();

  //Nos traemos de la api la lista de provincia al inicio -> initState
  late Future<List<Provincia>> provincias;
  PedidoService pedidoService = PedidoService();
  //En el initState llamar a la api para que traiga las provincias
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provincias = pedidoService.getProvincias();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(

        middle: Text('Nueva direccion'),
      ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text('Complete el formulario',
                      style: TextStyle(
                        color: amarillo,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                  ),
                  InputWidget(hint: 'Calle', marginTop: 10, paddingLeft: 10, textCtrl: calleCtrl),
                  Row(
                    children: [
                      Flexible(
                          child: InputWidget(hint: 'Numero', marginTop: 10, paddingLeft: 20, textCtrl: numeroCtrl)
                      ),
                      Flexible(
                          flex: 2,
                          child: InputWidget(hint: 'Puerta, piso, escalera', marginTop: 10, paddingLeft: 20, textCtrl: puertaCtrl)
                      )
                    ],
                  ),
                  InputWidget(hint: 'Codigo Postal', marginTop: 10, paddingLeft: 20, textCtrl: codPostalCtrl),
                  //El input que tiene la lista de provincias
                  //Como viene de una api desde el initState
                  FutureBuilder(
                    future: provincias,
                      builder: (context, snapshot){
                      if(snapshot.hasError){
                        return Text('Error');
                      }else if( snapshot.hasData){
                        return _dropDownProvincias(snapshot.data!);
                      }
                       return const LinearProgressIndicator();

                      }
                  )

                ],
              ),
            ),
          ),
        )
    );
  }

  Widget _dropDownProvincias(List<Provincia> list) {

  }
}
