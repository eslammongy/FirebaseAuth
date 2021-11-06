import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';

Widget textInputField({
  @required TextEditingController controller,
  @required TextInputType type,
  double size,
  Function onSubmit,
  Function onChange,
  Function onTap,
  @required Function validate,
  String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: AppColor.shapesColor,
          width: 2,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        autofocus: false,
        style: TextStyle(
            fontSize: 18,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0),
        onTap: onTap,
        validator: validate,
        cursorColor: Colors.amberAccent,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
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
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
