import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showLoadingDialog(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.white,
    elevation: 10,
    contentPadding: const EdgeInsets.all(5),
    content: SizedBox(
      height: 150,
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
            const SizedBox(
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

void showFlushBar(context, String message , String title) {
  Flushbar(
    mainButton: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Undo",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600))),
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: Colors.red,
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(15),
    borderRadius: BorderRadius.circular(15),
    animationDuration: const Duration(seconds: 5),
    duration: const Duration(seconds: 3),
    boxShadows: const [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 8,
      ),
    ],
    titleText:  Text(
      title,
      style: const TextStyle(
          color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600),
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    ),
    icon:  Icon(
      title == "Error" ? FontAwesomeIcons.infoCircle :FontAwesomeIcons.fileUpload ,
      color: Colors.black87,
    ),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  ).show(context);
}

