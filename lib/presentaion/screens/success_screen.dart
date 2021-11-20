import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/presentaion/widget/social_card.dart';

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
                Text(
                  "Welcome Back 😊",
                  style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      color: CustomColors.colorYellow),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
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
                Container(
                  width: double.infinity,
                  height: 65,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: AppColor.shapesColor,
                      width: 2,
                    ),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, userLoginScreen);
                      },
                      child: const Text(
                        "Login With Your Email",
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.2,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                ),

                buildSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google.png",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook.png",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/telephone.png",
                      press: () {
                        Navigator.pushNamed(context, phoneAuthScreen);
                      },
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSpacer() {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          "OR",
          style: TextStyle(
              fontSize: 25,
              letterSpacing: 1.0,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
              color: CustomColors.colorYellow),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }


}
