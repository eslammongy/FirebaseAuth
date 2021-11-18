import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget textInputFormField(
    {required TextEditingController textEditingController,
    required String label,
    required Widget prefix,
    required double textSize,
    required bool autoFocus}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: HexColor("2C313C")),
    child: TextFormField(
      autofocus: autoFocus,
      controller: textEditingController,
      style: TextStyle(
        fontSize: textSize,
        letterSpacing: 1.5,
      ),
      decoration: InputDecoration(
          label: Text(label),
          labelStyle: TextStyle(
            fontSize: 15,
            fontFamily: "Roboto",
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: prefix),
      cursorColor: Colors.black,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "please $label !";
        }
        return null;
      },
      onSaved: (value) {
        textEditingController.text = value!;
      },
    ),
  );
}
