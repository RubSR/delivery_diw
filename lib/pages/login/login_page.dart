import 'package:delivery_diw/utils/colors/colors.dart';
import 'package:delivery_diw/widgets/button_widget.dart';
import 'package:delivery_diw/widgets/input_widget.dart';
import 'package:delivery_diw/widgets/stack_widget.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  @override
  Widget build(BuildContext context) {

    TextEditingController emailCtrl = TextEditingController();
    TextEditingController passwordCtrl = TextEditingController();
    bool disabled = false;

  //Devolvia el ancho de la pantalla
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

  void _loginUser() {}
}

