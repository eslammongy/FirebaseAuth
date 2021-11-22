
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/data/user_model.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';


void showingGeneralDialog(BuildContext context , String signInMethod){
  var userModel = FirebaseAuthAppCubit.get(context).userModel;
  var etNameController = TextEditingController();
  var etEmailController = TextEditingController();
  var etPhoneController = TextEditingController();
  var etBioController = TextEditingController();
  etNameController.text = userModel.name;
  etEmailController.text = userModel.email;
  etPhoneController.text = userModel.phone;
  etBioController.text = userModel.bio;
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context)
          .modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation) {
        return Container(
          margin:const EdgeInsets.only(top: 80),
          child: Material(
            animationDuration: const Duration(milliseconds: 400),
            color: Colors.black54.withAlpha(0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration:  BoxDecoration(
                    color: CustomColors.backgroundColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      textInputFormField(
                      textEditingController: etNameController,
                      label: "full name",
                      isTextPassword:false,
                      isTextBio: false,
                      prefix: const Icon(Icons.person),
                      autoFocus: false,
                      textSize: 18.0),
                  const SizedBox(
                    height: 20,
                  ),
                  textInputFormField(
                      textEditingController: etEmailController,
                      label: "email",
                      isTextPassword:false,
                      autoFocus: false,
                      isTextBio: false,
                      prefix: const Icon(Icons.email),
                      textSize: 18.0),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: signInMethod == "Phone"? const SizedBox(height: 1,)  : textInputFormField(
                        textEditingController: etPhoneController,
                        label: "phone",
                        isTextBio: false,
                        isTextPassword:false,
                        prefix: const Icon(Icons.person),
                        autoFocus: false,
                        textSize: 18.0)
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textInputFormField(
                      textEditingController: etBioController,
                      label: "Bio",
                      isTextBio: true,
                      isTextPassword:false,
                      textInputType: TextInputType.multiline,
                      prefix: const Icon(Icons.info),
                      autoFocus: false,
                      textSize: 16.0),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: buildButtonShape(
                        buttonText: "Save",
                        buttonWidth: 150.0,
                        context: context,
                        onPressed: () {
                          FirebaseAuthAppCubit
                              .get(context)
                              .userModel = UserModel(name: '', uId: '', phone: '', email: '', image: userModel.image , bio: "");

                            FirebaseAuthAppCubit.get(context).updateInfo(etNameController , etEmailController , etPhoneController ,etBioController);
                            Navigator.pop(context);


                        }),
                    )]
                ),
                ),
              ],
            ),
          ),
        );
      },
  transitionBuilder: (context, anim1, anim2, child) {
    return SlideTransition(
      position: Tween(begin:const Offset(0 , 1), end: const Offset(0 , 0)).animate(anim1),
      child: child,
    );
  });
}

