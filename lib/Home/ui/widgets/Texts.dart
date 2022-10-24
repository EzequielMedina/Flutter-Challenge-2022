import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  final String cadena;
  final String cadenaValue;
  const Texts(  this.cadena,  this.cadenaValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("$cadena : $cadenaValue",
        textAlign: TextAlign.right,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16));
  }
}