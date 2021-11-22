import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  var etEmailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              margin:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, userLoginScreen);
                      },
                      icon: Icon(
                        FontAwesomeIcons.arrowAltCircleLeft,
                        size: 30,
                        color: CustomColors.colorGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800,
                        color: CustomColors.colorGrey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Enter them email associated with your account and well send an email with instructions to reset your password.",
                    style: TextStyle(
                        fontSize: 20,
                        height: 1.1,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/password.png",
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textInputFormField(
                      textEditingController: etEmailController,
                      label: "enter your email",
                      prefix: const Icon(Icons.email),
                      textSize: 20.0,
                      isTextBio: false,
                      isTextPassword:false,
                      textInputType: TextInputType.name,
                      autoFocus: false),

                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: AppColor.shapesColor,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 3),
                            )
                          ]),
                      child: TextButton(
                          onPressed: () {
                            showLoadingDialog(context);
                            FirebaseAuthAppCubit.get(context).userResetPassword(etEmailController.text);
                          },
                          child: const Text(
                            "Send",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  createUserStates()
                ],
              ),
            )),
      ),
    );
  }

  Widget createUserStates() {
    return BlocListener<FirebaseAuthAppCubit, FirebaseAuthAppState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is UserResetPasswordLoading) {
          showLoadingDialog(context);
        }
        if (state is UserResetPasswordSuccess) {
          Navigator.pop(context);
          Navigator.of(context)
              .pushReplacementNamed(userResetCodeSentScreen);
        }
        if (state is UserResetPasswordError) {
          Navigator.pop(context);
          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg , "Error");
        }
      },
      child: Container(),
    );
  }
}
