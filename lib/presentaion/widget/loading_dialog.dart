import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';

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

void showFlushBar(context, String message) {
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
    duration: const Duration(seconds: 8),
    boxShadows: const [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 8,
      ),
    ],
    titleText: const Text(
      "Error",
      style: TextStyle(
          color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600),
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    ),
    icon: const Icon(
      Icons.info_sharp,
      color: Colors.black87,
    ),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  ).show(context);
}

void showEditingInfoDialog(BuildContext context) {
  var userModel = FirebaseAuthAppCubit.get(context).userModel;
  var eTextNameController = TextEditingController();
  var eTextEmailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  eTextNameController.text = userModel.name;
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: AppColor.shapesColor,
                  width: 2,
                ),
              ),
              child: textInputFormField(
                  textEditingController: eTextNameController,
                  label: "full name",
                  isTextPassword:false,
                  prefix: const Icon(Icons.person),
                  autoFocus: false,
                  textSize: 18.0)),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: AppColor.shapesColor,
                width: 2,
              ),
            ),
            child: textInputFormField(
                textEditingController: eTextEmailController,
                label: "email",
                isTextPassword:false,
                autoFocus: false,
                prefix: const Icon(Icons.email),
                textSize: 18.0),
          ),
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: buildButtonShape(
                buttonText: "Save",
                buttonWidth: 150.0,
                context: context,
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  } else {
                    formKey.currentState!.save();
                    FirebaseAuthAppCubit.get(context)
                        .updateInfo(eTextNameController, eTextEmailController);
                    Navigator.pop(context);
                  }
                  //AwesomeDialog(context: context).dismiss();
                }),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    ),
  ).show();
}
