import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:hexcolor/hexcolor.dart';

Widget textInputFormField(
    {required TextEditingController textEditingController,
    required String label,
    required Widget prefix,
    required double textSize,
       required bool isTextPassword,
      required bool isTextBio,
    required bool autoFocus , TextInputType? textInputType , IconData? suffix,
      Function()? suffixPressed,}) {

  return Container(
    height: isTextBio ? 120 : 60,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: HexColor("2C313C")),
    child: TextFormField(
      autofocus: autoFocus,
      obscureText: isTextPassword,
      maxLines: isTextPassword ? 1 : 4,
      controller: textEditingController,
      style: TextStyle(
        fontSize: textSize,
        color: CustomColors.colorGrey,
        letterSpacing: 1.5,
      ),
      decoration: InputDecoration(
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
          label: Text(label),
          prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
      ),
      cursorColor: Colors.black,
      keyboardType: textInputType,
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
