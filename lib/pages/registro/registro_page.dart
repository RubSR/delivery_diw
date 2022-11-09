import 'package:delivery_diw/models/api_reponse.dart';
import 'package:delivery_diw/pages/registro/provider/registro_provider.dart';
import 'package:delivery_diw/widgets/back_button.dart';
import 'package:delivery_diw/widgets/button_widget.dart';
import 'package:delivery_diw/widgets/input_widget.dart';
import 'package:delivery_diw/widgets/stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
   TextEditingController emailCtrl = TextEditingController();
   TextEditingController passwordCtrl = TextEditingController();
   TextEditingController nombreCtrl = TextEditingController();
   TextEditingController apellidosCtrl = TextEditingController();
   TextEditingController telefonoCtrl = TextEditingController();
   
   bool disabled = false;
  
  @override
  Widget build(BuildContext context) {
    return StackWidget( 
      backButton: backButton(Colors.white, context),
      img: 'assets/images/fondo-Welcome.jpeg',
      altoContenedor: 2.0,
      altoImg: 0.4,
      widgets: [
        const Text('Registro',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30),
        InputWidget(hint: 'Nombre', marginTop: 10,
            paddingLeft: 20, textCtrl: nombreCtrl),
        InputWidget(hint: 'Apellidos', marginTop: 10,
            paddingLeft: 20, textCtrl: apellidosCtrl),
        InputWidget(hint: 'Telefono', marginTop: 10, paddingLeft: 20,
            textCtrl: telefonoCtrl, keyboardType: TextInputType.phone),
        InputWidget(hint: 'Email', marginTop: 10,
            paddingLeft: 20, textCtrl: emailCtrl,
          keyboardType: TextInputType.emailAddress,),
        InputWidget(hint: 'Contraseña', marginTop: 10, paddingLeft: 20,
            textCtrl: passwordCtrl, obscure: true,),
        ButtonWidget(marginTop: 40, 
            texto: 'Crear cuenta', 
            ancho: 0.4, alto: 0.05, 
            onClick: (){
              _registrarUsuario();
            })

      ]
    );
  }

   _registrarUsuario() async {

    setState(() {
      disabled = true;
    });

    Map<String,dynamic> cliente = {
      'user':{
        'email': emailCtrl.text,
        'password': passwordCtrl.text,
      },
      'role': 'ROLE_CLIENTE',
      'cliente': {
        'nombre': nombreCtrl.text,
        'apellidos':apellidosCtrl.text,
        'telefono': telefonoCtrl.text,
      }
    };

    //LLamar a la api y enviarle el cliente
     RegistroService registroService = RegistroService();
     ApiResponse apiResponse = await registroService.registroUser(cliente);
     if(!apiResponse.error){
       Navigator.pop(context);
     }else{
       //Mostrar un mensaje diciendo que ha ocurrido un error.
       Fluttertoast.showToast(msg: apiResponse.apiErrorMessage);
     }
     setState(() {
       //Activamos de nuevo el boton
       disabled = false;
     });

   }
}
