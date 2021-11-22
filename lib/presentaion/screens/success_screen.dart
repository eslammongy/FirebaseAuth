import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/constants/colors.dart';
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
                buildSignInOptions(context, "SignIn With Google", FontAwesomeIcons.google , (){}),
                const SizedBox(
                  height: 15,
                ),
                buildSignInOptions(context, "SignIn With Facebook", FontAwesomeIcons.facebookF, (){}),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildSignInOptions(BuildContext context, String text , IconData iconData , Function()? onPressed) {
    return    InkWell(
      onTap: onPressed,
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
