// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/screens/success_screen.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserLoginScreen extends StatelessWidget {
  var etPasswordController = TextEditingController();
  var eTextEmailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  UserLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              autovalidate: true,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, welcomeScreen);
                           },
                        icon: Icon(
                          FontAwesomeIcons.arrowAltCircleLeft,
                          size: 30,
                          color: CustomColors.colorGrey,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/firebase_logo.png",
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Login to your account 😊",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: CustomColors.colorYellow),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    textInputFormField(
                        textEditingController: eTextEmailController,
                        label: "enter your email",
                        prefix: const Icon(Icons.email),
                        textSize: 20.0,
                        isTextPassword: false,
                        isTextBio: false,
                        textInputType: TextInputType.emailAddress,
                        autoFocus: false),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<FirebaseAuthAppCubit , FirebaseAuthAppState>(
                      builder: (context , state){
                        return textInputFormField(
                        textEditingController: etPasswordController,
                        label: "enter your password",
                        prefix: const Icon(Icons.lock_rounded),
                        textSize: 20.0,
                            isTextBio: false,
                        isTextPassword:  FirebaseAuthAppCubit.get(context).isPasswordShowing,
                        textInputType: TextInputType.visiblePassword,
                        suffix:FirebaseAuthAppCubit.get(context).suffix ,
                        suffixPressed:(){
                        FirebaseAuthAppCubit.get(context).changePasswordVisibility();
                        },
                        autoFocus: false);
                      }

                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(onPressed: (){
                        Navigator.pushNamed(context, userForgetPasswordScreen);
                      }, child: Text(
                        "Forget Password ?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            color: CustomColors.colorYellow),
                      ),)
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: CustomColors.colorOrange,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 2),
                            )
                          ]),
                      child: TextButton(
                          onPressed: () {
                            showLoadingDialog(context);
                            userSignInToAccount(context);
                          },
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Roboto",
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ?",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: CustomColors.colorYellow),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, userRegistrationScreen);
                          },
                          child: Text(
                            "Sign Up ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.colorAmber),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    createUserStates(),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget createUserStates() {
    return BlocListener<FirebaseAuthAppCubit, FirebaseAuthAppState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is UserLoginLoadingState) {
          showLoadingDialog(context);
        }
        if (state is UserLoginSuccessState) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(welcomeScreen);
        }
        if (state is UserLoginErrorState) {
          Navigator.pop(context);
          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg);
        }
      },
      child: Container(),
    );
  }

  void userSignInToAccount(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      formKey.currentState!.save();
      FirebaseAuthAppCubit.get(context).userLogin(
          email: eTextEmailController.text,
          password: etPasswordController.text,
        );
    }
  }

}
