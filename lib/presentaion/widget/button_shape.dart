import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';

Widget buildButtonShape(
    {required String buttonText,
    required double buttonWidth,
    required BuildContext context,
    required Function() onPressed}) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      width: buttonWidth,
      height: 60,
      decoration: BoxDecoration(
          color: AppColor.shapesColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, 3),
            )
          ]),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )),
    ),
  );
}
