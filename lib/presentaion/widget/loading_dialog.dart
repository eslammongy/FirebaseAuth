import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';

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

void showFlushbar(context, String message) {
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
    duration: Duration(seconds: 9),
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
