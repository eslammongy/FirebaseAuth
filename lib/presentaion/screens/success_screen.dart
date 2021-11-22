import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomesScreen extends StatelessWidget {
  const WelcomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/welcome.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildSignInOptions(context, "SignIn With Email", Icons.email_rounded , (){
                  Navigator.pushReplacementNamed(context, userLoginScreen);
                }),
                const SizedBox(
                  height: 15,
                ),
                buildSignInOptions(context, "SignIn With Phone", FontAwesomeIcons.phoneSquare , (){
                  Navigator.pushReplacementNamed(context, phoneAuthScreen);
                }),
                const SizedBox(
                  height: 15,
                ),
                buildSignInOptions(context, "SignIn With Google", FontAwesomeIcons.google , (){
                  FirebaseAuthAppCubit.get(context).userSignInWithGoogleAccount();
                }),
                const SizedBox(
                  height: 15,
                ),
                buildSignInOptions(context, "SignIn With Facebook", FontAwesomeIcons.facebookF, (){}),
                createUserStates()
              ],
            ),
          ),
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
          showFlushBar(context, "Finishing signIn with google account successfully" , "Info");
          Navigator.of(context).pushReplacementNamed(createAccountScreen , arguments:FirebaseAuthAppCubit.get(context).googleAccount);
        }
        if (state is UserLoginErrorState) {

          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg , "Error");
        }
      },
      child: Container(),
    );
  }

  Widget buildSignInOptions(BuildContext context, String text , IconData iconData , Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      splashColor: CustomColors.googleBackground,
      borderRadius:  const BorderRadius.all(Radius.circular(40)),
      child: Container(
        width: double.infinity,
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            color: AppColor.shapesColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
          Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              letterSpacing: 1.2,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
            const Spacer(),
            Icon(iconData , color: CustomColors.googleBackground,)
          ],
        ),
      ),
    );
  }


}
