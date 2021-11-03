import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';

class CreateUserAccount extends StatelessWidget {
  CreateUserAccount({Key key}) : super(key: key);

  var textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  "What about you?",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w800,
                      color: AppColor.textColor),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Please enter your phone number to verify your account.",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor),
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.purple[700].withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Image.asset(
                      "assets/images/photo_camera.png",
                      width: 110,
                      height: 110,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                textInputField(
                    controller: textEditingController,
                    type: TextInputType.name,
                    validate: (_) {},
                    label: "first name",
                    prefix: Icons.person),
                SizedBox(
                  height: 20,
                ),
                textInputField(
                    controller: textEditingController,
                    type: TextInputType.name,
                    validate: (_) {},
                    label: "last name",
                    prefix: Icons.person),
                SizedBox(
                  height: 90,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By registering you agree to Terms & Conditions and Privacy Policy of the app.",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            color: AppColor.textColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: AppColor.shapesColor,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
