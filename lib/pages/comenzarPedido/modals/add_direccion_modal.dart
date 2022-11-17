import 'package:delivery_diw/pages/comenzarPedido/providers/pedido_provider.dart';
import 'package:delivery_diw/utils/colors/colors.dart';
import 'package:delivery_diw/widgets/button_widget.dart';
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
  Provincia? provincia;
  Municipio? municipio;

  //Nos traemos de la api la lista de provincia al inicio -> initState
  late Future<List<Provincia>> provincias;
  PedidoService pedidoService = PedidoService();


  List<Municipio> municipios = [];
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
                          child: InputWidget(hint: 'Numero', marginTop: 10, paddingLeft: 10, textCtrl: numeroCtrl)
                      ),
                      Flexible(
                          flex: 2,
                          child: InputWidget(hint: 'Puerta, piso, escalera', marginTop: 10, paddingLeft: 10, textCtrl: puertaCtrl)
                      )
                    ],
                  ),
                  InputWidget(hint: 'Codigo Postal', marginTop: 10, paddingLeft: 10, textCtrl: codPostalCtrl),
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
                  ),

                  _dropDownMunicipios(),

                  _crearButton(),

                ],
              ),
            ),
          ),
        )
    );
  }

  Widget _dropDownProvincias(List<Provincia> listaProvincias) {

    return Container(
      width: 370,
      height: 50,
      margin:  EdgeInsets.only(top:10),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: inputGris,
        borderRadius: BorderRadius.circular(40)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Provincia>(
          isExpanded: true,
          hint:  Text('Seleccine provincia'),
          // es lo que va adevolver la lista cuando seleccionemos una provincia
          // y a la vez a partir de la variable desde codigo podemos esrtablcer que provincia
          // tiene seleccionado el dropdow
          value: provincia,
          //Se dispara cada vez que seleccionamos una provincia de la lista
          onChanged: (Provincia? newProvincia) async {

            setState(() {
              provincia = newProvincia;
              //La lista de municipios cambia -> municipio seleccionado ya no puede existir
              // porque la lista de donde proviene ha cambiado
              municipio = null;
            });
            //LLamar a la api y en base a la provincia seleccionada traernos
            // los municipios
            municipios = await pedidoService.getMunicipios(provincia!.id!);
            setState(() {

            });
          },
          //Rellenamos el select a partir de la lista de provincias que tenemos
          items: listaProvincias.map((Provincia prov) {
            return DropdownMenuItem<Provincia>(
                value: prov,
                child: Text(prov.provincia!)
            );
          }).toList(),
        ),
      ),
    );
  }

 Widget _dropDownMunicipios() {
    return Container(
      width: 370,
      height: 50,
      margin: EdgeInsets.only(top:10),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: inputGris,
        borderRadius: BorderRadius.circular(40)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Municipio>(
          isExpanded: true,
          hint: Text('Seleccione municipio'),
          value: municipio,
          onChanged: (Municipio? newMunicipio){
            setState(() {
              municipio = newMunicipio;
            });
          },
          items: municipios.map((Municipio muni) {
            return DropdownMenuItem<Municipio>(
                value: muni,
                child: Text(muni.municipio!)
            );
          }).toList(),
        ),
      ),
    );
 }

 Widget _crearButton() {
    return ButtonWidget(
        marginTop: 30,
        texto: 'Guardar',
        ancho: 0.9,
        alto: 0.05,
        onClick: (){
          //TODO: Guardar la direccion en bd, pasandosela a la api
        }
    );
 }
}

