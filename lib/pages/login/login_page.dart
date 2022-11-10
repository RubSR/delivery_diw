import 'package:delivery_diw/models/api_reponse.dart';
import 'package:delivery_diw/pages/login/provider/login_provider.dart';
import 'package:delivery_diw/utils/colors/colors.dart';
import 'package:delivery_diw/widgets/button_widget.dart';
import 'package:delivery_diw/widgets/input_widget.dart';
import 'package:delivery_diw/widgets/stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool disabled = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();


   @override
  Widget build(BuildContext context) {
     return StackWidget(
      altoImg: 0.5,
        altoContenedor: 0.6,
        img: 'assets/images/login-fondo.jpeg',
        widgets: [
          const Text('Bienvenido',
            style: TextStyle(
                fontWeight: FontWeight.bold,
              fontSize: 26.0
            ),),
          const Text('Accede a tu cuenta',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 13.0
              ),
          ),
          InputWidget(hint: 'Email', marginTop: 40.0, paddingLeft: 20.0, textCtrl: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          InputWidget(hint: 'Contraseña', marginTop: 10.0, paddingLeft: 20.0, textCtrl: passwordCtrl,
          obscure: true,
          ),
          //Boton entrar para hacer login
          ButtonWidget(
              marginTop: 30.0, 
              texto: 'Entrar', 
              ancho: 0.5, 
              alto: 0.05,
              disabled: disabled,
              onClick: (){
                _loginUser();
              }),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿Aun no tienes cuenta?',
                style: TextStyle(
                  color: gris,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0
                ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/registro');
                  },
                  child:const Text(' Registro',
                  style: TextStyle(
                    color: amarillo,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0
                  ),
                  ),

                )
              ],
            ),
          )

        ]
    );
  }

  void _loginUser() async {
    setState(() {
      disabled = true;
    });
    Map<String, dynamic> user = {
      'username': emailCtrl.text,
      'password': passwordCtrl.text,
    };

    LoginService loginService = LoginService();
    ApiResponse apiResponse = await loginService.loginUser(user);
    // Segun lo que venga de la api hacemos una cosa u otra
    if(!apiResponse.error){

      //TODO:Ir a la pagina de comenzar pedido
      //Navigator.pusNamed-> añadir a la pila de navegacion la pagina
      // que podiamos navegar hacia a atrás
      //Como vamos a navegar desde el login . Me interesa que el usuario pueda
      //volver a atras?
      //Navega y borra todo el historial de navagacion
      Navigator.pushReplacementNamed(context, '/pedido');

    }else{
      Fluttertoast.showToast(msg: 'Credenciales incorrectos');
    }
    setState(() {
      disabled = false;
    });
  }
}

