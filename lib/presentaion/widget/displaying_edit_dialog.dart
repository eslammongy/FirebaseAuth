
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/data/user_model.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void showingGeneralDialog(BuildContext context , String signInType){
  var userModel = FirebaseAuthAppCubit.get(context).userModel;
  var etNameController = TextEditingController();
  var etEmailController = TextEditingController();
  var etPhoneController = TextEditingController();
  var etBioController = TextEditingController();
  etNameController.text = userModel.name;
  etEmailController.text = userModel.email;
  etPhoneController.text = userModel.phone;
  etBioController.text = userModel.bio;
  var height = MediaQuery.of(context).size.height;
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
                  height:  height * 0.75,
                  margin:const EdgeInsets.only(bottom: 80),
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
                        height: 15,
                      ),
                      Container(
                        child: signInType.contains("Email")  ? textInputFormField(
                            textEditingController: etPhoneController,
                            label: "enter your phone",
                            prefix: const Icon(FontAwesomeIcons.phoneAlt),
                            textSize: 20.0,
                            isTextBio: false,
                            isTextPassword:false,
                            textInputType: TextInputType.phone,
                            autoFocus: false) :textInputFormField(
                            textEditingController: etEmailController,
                            label: "enter your email",
                            prefix: const Icon(Icons.email),
                            textSize: 18.0,
                            isTextBio: false,
                            isTextPassword:false,
                            textInputType: TextInputType.emailAddress,
                            autoFocus: false),
                      ),

                      Container(
                        child: signInType == "Default" ? Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            textInputFormField(
                                textEditingController: etPhoneController,
                                label: "enter your phone",
                                prefix: const Icon(FontAwesomeIcons.phoneAlt),
                                textSize: 20.0,
                                isTextBio: false,
                                isTextPassword:false,
                                textInputType: TextInputType.phone,
                                autoFocus: false),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ) :const SizedBox(
                          height: 15,
                        ),
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
                    height: 10,
                  ),
                const  Spacer(),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Row(
                      children: [
                        buildButtonShape(
                            buttonText: "Cancel",
                            buttonWidth: 150.0,
                            context: context,
                            onPressed: () {
                              FirebaseAuthAppCubit
                                  .get(context)
                                  .userModel = UserModel(name: '', uId: '', phone: '', email: '', image: userModel.image , bio: "");

                              FirebaseAuthAppCubit.get(context).updateInfo(etNameController , etEmailController , etPhoneController ,etBioController);
                              Navigator.pop(context);


                            }),
                       const Spacer(),
                        buildButtonShape(
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
                      ],
                    ),
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

