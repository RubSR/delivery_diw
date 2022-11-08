import 'package:delivery_diw/utils/colors/colors.dart';
import 'package:flutter/material.dart';


class InputWidget extends StatelessWidget {
  final double marginTop;
  final double paddingLeft;
  final TextInputType keyboardType;
  final bool obscure;
  final TextEditingController textCtrl;
  final String hint;


  const InputWidget({Key? key,
    required this.hint,
    required this.marginTop,
    required this.paddingLeft,
    required this.textCtrl,
    this.obscure = false,
    this.keyboardType = TextInputType.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: marginTop),
      padding: EdgeInsets.only(left: paddingLeft),
      decoration: BoxDecoration(
        color: inputGris,
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscure,
        controller: textCtrl,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(borderSide: BorderSide.none)
        ),
      ),
    );
  }
}
