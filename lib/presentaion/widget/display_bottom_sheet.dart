
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';

void displayingBottomSheet(BuildContext context){
  var userModel = FirebaseAuthAppCubit.get(context).userModel;
  var etNameController = TextEditingController();
  var etEmailController = TextEditingController();
  var etPhoneController = TextEditingController();
  var etBioController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  showModalBottomSheet(context: context ,
      backgroundColor: CustomColors.backgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder:(context){
    etNameController.text = userModel.name;
    etEmailController.text = userModel.email;
    etPhoneController.text = userModel.phone;
      etBioController.text = userModel.bio!;

        return Container(
          width: double.infinity,
          height:  MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(

              children: [
                const SizedBox(
                  height: 60,
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
                textInputFormField(
                    textEditingController: etPhoneController,
                     label: "phone",
                    isTextBio: false,
                    isTextPassword:false,
                    prefix: const Icon(Icons.person),
                    autoFocus: false,
                    textSize: 18.0),
                const SizedBox(
                  height: 20,
                ),
                textInputFormField(
                    textEditingController: etBioController,
                    label: "Bio",
                    isTextBio: true,
                    isTextPassword:false,
                    prefix: const Icon(Icons.info),
                    autoFocus: false,
                    textSize: 18.0),
                const SizedBox(
                  height: 60,
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
                          FirebaseAuthAppCubit.get(context).updateCurrentUserFullInfo(
                          name: etNameController.text , email: etEmailController.text , phone: etPhoneController.text , bio: etBioController.text
                          );
                          Navigator.pop(context);
                        }

                      }),
                ),

              ],
            ),
          ),
        );
      });
}