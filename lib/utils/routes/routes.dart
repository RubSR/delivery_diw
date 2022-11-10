

import 'package:delivery_diw/pages/comenzarPedido/comenzar_pedido_page.dart';
import 'package:delivery_diw/pages/login/login_page.dart';
import 'package:delivery_diw/pages/registro/registro_page.dart';
import 'package:flutter/widgets.dart';

final routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => LoginPage(),
  '/registro': (BuildContext context) => RegistroPage(),
  '/pedido': (BuildContext context) => PedidoPage(),
};