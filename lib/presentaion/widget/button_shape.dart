import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';

Widget buildButtonShape(
    {String buttonText,
    double buttonWidth,
    BuildContext context,
    Function onPressed}) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      width: buttonWidth,
      height: 60,
      decoration: BoxDecoration(
          color: AppColor.shapesColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.5),
              offset: Offset(0, 3),
            )
          ]),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )),
    ),
  );
}
