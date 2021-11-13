import 'package:flutter/material.dart';

Widget textInputFormField(
    {required TextEditingController textEditingController,
    required String label,
    required Widget prefix,
    required double textSize,
    required bool autoFocus}) {
  return TextFormField(
    autofocus: autoFocus,
    controller: textEditingController,
    style:  TextStyle(
      fontSize: textSize,
      letterSpacing: 1.5,
    ),
    decoration: InputDecoration(
      prefix: prefix,
      label: Text(label),
      labelStyle: const TextStyle(
        fontSize: 15,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
      ),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding:
          const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
    ),
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
  );
}
