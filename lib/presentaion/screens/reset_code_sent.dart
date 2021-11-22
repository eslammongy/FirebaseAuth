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
class ResetCodeSent extends StatelessWidget {
  var etEmailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ResetCodeSent({Key? key}) : super(key: key);

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
                  const SizedBox(height: 100),
                  Center(
                    child: Text(
                      "Check Your Email",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w800,
                          color: CustomColors.colorGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                    Center(
                     child: Container(
                       margin:const EdgeInsets.symmetric(horizontal: 15),
                       child: const Text(
                        "We have sent recover instructions to your email.",
                        style: TextStyle(
                            fontSize: 20,
                            height: 1.1,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                  ),
                     ),
                   ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/email_sent.png",
                      width: 150,
                      height: 150,
                    ),
                  ),
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
                          Navigator.pushReplacementNamed(context, userLoginScreen);
                          },
                          child: const Text(
                            "Go To Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w800,
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
              .pushNamed(userLoginScreen);
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
