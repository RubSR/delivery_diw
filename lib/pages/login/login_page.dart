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
  //Devolvia el ancho de la pantalla
    return StackWidget(
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
          )
        ]
    );
  }
}

