import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/logic/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';

void showLoadingDialog(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.white,
    elevation: 10,
    contentPadding: EdgeInsets.all(5),
    content: Container(
      height: 150,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
            SizedBox(
              height: 20,
            ),
            Text(
              "please waiting...",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor),
            )
          ],
        ),
      ),
    ),
  );

  showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (context) {
        return alertDialog;
      });
}

void showFlushBar(context, String message) {
  Flushbar(
    mainButton: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Undo",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600))),
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: Colors.red,
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(15),
    borderRadius: 15,
    animationDuration: Duration(seconds: 2),
    duration: Duration(seconds: 2),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 8,
      ),
    ],
    titleText: Text(
      "Error",
      style: TextStyle(
          color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600),
    ),
    messageText: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 15),
    ),
    icon: Icon(
      Icons.info_sharp,
      color: Colors.black87,
    ),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  ).show(context);
}

void showEditingInfoDialog(BuildContext context) {
  var userModel = PhoneAuthCubit.get(context).userModel;
  var eTextNameController = TextEditingController();
  var eTextEmailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  eTextNameController.text= userModel.name;
  eTextEmailController.text = userModel.email;

  AwesomeDialog(
    context: context,
    dismissOnTouchOutside: false,
    animType: AnimType.TOPSLIDE,
    dialogType: DialogType.INFO,
    customHeader: CircleAvatar(
      radius: 68.0,
      backgroundColor: Colors.white12,
      child: CircleAvatar(
          radius: 65.0, backgroundImage: NetworkImage(userModel.image)),
    ),
    body: Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            textInputField(
                controller: eTextNameController,
                type: TextInputType.name,
                validate: (String value) {
                  if (value.isEmpty) {
                    return "please enter your name !";
                  }
                },
                label: "full name",
                prefix: Icons.person),
            SizedBox(
              height: 30,
            ),
            textInputField(
                controller: eTextEmailController,
                type: TextInputType.emailAddress,
                validate: (String value) {
                  if (value.isEmpty) {
                    return "please enter your name !";
                  }
                },
                label: "email",
                prefix: Icons.email_rounded),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: buildButtonShape(buttonText: "Save" , buttonWidth: 150.0 , context: context , onPressed: (){
                if (!formKey.currentState.validate()) {
                  return;
                } else {

                  formKey.currentState.save();
                  PhoneAuthCubit.get(context).updateInfo(eTextNameController, eTextEmailController);
                  Navigator.pop(context);
                }
                //AwesomeDialog(context: context).dismiss();
              }),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    ),

  )..show();
}

