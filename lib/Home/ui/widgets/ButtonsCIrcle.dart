import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Butons extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onPressed;
  const Butons(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: CupertinoButton(
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          )),
    );
  }
}
