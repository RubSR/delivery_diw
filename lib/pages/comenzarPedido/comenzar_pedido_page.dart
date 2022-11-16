import 'package:delivery_diw/pages/comenzarPedido/modals/direcciones_modal.dart';
import 'package:delivery_diw/pages/comenzarPedido/providers/pedido_provider.dart';
import 'package:delivery_diw/utils/colors/colors.dart';
import 'package:delivery_diw/widgets/stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../models/Cliente.dart';


class PedidoPage extends StatefulWidget {
  const PedidoPage({Key? key}) : super(key: key);

  //1. Necesitamos el modelo de datos para crearnos un objeto de tipo cliente


  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  //1.Necesitamos un future de tipo Cliente
  late Future<Cliente> cliente;
  //2. Traerno el servicio
  PedidoService pedidoService = PedidoService();
  //3.Llamar a la api endpoint de Get /cliente/{id} en el initState

  Direcciones? direccionSeleccionada;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cliente = pedidoService.getCliente();
  }

  @override
  Widget build(BuildContext context) {
    return StackWidget(
      img: 'assets/images/login-fondo.jpeg',
      altoContenedor: 0.6,
      altoImg: 0.45,
      widgets: [
        const Text('Comienza tu pedido',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),
        ),
        const Text('Selecciona una direccion, el dia y la hora de reparto',
          style: TextStyle(
            color: gris, fontWeight: FontWeight.w500, fontSize: 13.0
          )
        ),
        FutureBuilder(
            future: cliente,
            builder: (context, snapshot) {
              //1.Si hay error
              if(snapshot.hasError){
                return Container(
                  margin:const EdgeInsets.only(top: 50),
                  child: Text(snapshot.error.toString()),
                );
              }
              //2.Si todo ok y ya tenemos datos
              else if(snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(height: 30,),
                    const Text('Direccion de envio',
                    style: const TextStyle(
                      color: gris, fontWeight: FontWeight.w500, fontSize: 15.0
                    ),
                    ),
                    const SizedBox(height: 30,),
                    //TODO: Añadir mas cosas
                    //1.Un texto que se puede presionar que abrira es modal
                    // que nos muestra nuestras direcciones para seleccionar una de ellas
                    GestureDetector(
                      onTap: (){
                        showBarModalBottomSheet(
                            expand: true,
                            context: context,
                            builder: (context)=>
                            //Le pasamos nuestras direcciones ...
                            //Y cuando se cierre necesitamos una manera de capturar la direccion que se ha seleccionado
                                SelecDireccionPage(direcciones: snapshot.data!.direcciones!)

                        //Se espera a que termine o se cierre el widget
                          //y recibe por parametro lo que devuelve el widget
                        ).then((value) {
                          //Comprobar que no sea null ya que cuandop se cierra el modal de forma
                          //manual no se selecciona direccion por lo tanto value = null
                          if(value != null){
                            //Me guardo el value en una variable ojo de tipo Direccion
                            //y actulizo el estado del widget
                            setState(() {
                              direccionSeleccionada = value;
                            });

                          }

                        });

                      },
                      child: const Text('Seleccionar direccion',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                      ),
                      ),
                    ),
                    _direccionSeleccionada(),
                  ],
                );
              }
              //3. Widget que aparece durante la carga
              return const Center(child: CircularProgressIndicator());
            }
        )


      ]

    );
  }

 Widget _direccionSeleccionada() {
    if(direccionSeleccionada == null){
      return SizedBox();
    }
    return Container(
      margin:  EdgeInsets.only(top: 10),
      child: Card(
        color:  Color.fromRGBO(208, 207, 207, 1.0),
        child: ListTile(
          title: Text('${direccionSeleccionada!.calle!}, ${direccionSeleccionada!.numero!}, ${direccionSeleccionada!.puertaPisoEscalera!}'),
          subtitle: Text('${direccionSeleccionada!.provincia!.provincia!}, ${direccionSeleccionada!.municipio!.municipio!}, ${direccionSeleccionada!.codPostal!} '),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              setState(() {
                direccionSeleccionada = null;
              });
            },
          ),
        ),
      ),
    );

 }
}
