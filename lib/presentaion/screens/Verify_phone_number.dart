import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/presentaion/screens/create_user_account.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:flutter_maps/presentaion/widget/upper_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneNumber extends StatelessWidget {
  VerifyPhoneNumber({Key key}) : super(key: key);
  var textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayUpperView(
                    "Verify your phone number",
                    "Enter your 6 digit code numbers sent to you at",
                    "01020260714"),
                buildPinCodeContainer(context),
                SizedBox(
                  height: 40,
                ),
                buildButtonShape(
                    buttonText: "Verify",
                    context: context,
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(createAccountScreen);
                    }),
                SizedBox(
                  height: 90,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn’t recieve a verification code?",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            color: AppColor.textColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Resend code",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w200,
                                color: AppColor.shapesColor),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 30,
                            width: 2,
                            color: AppColor.textColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            " Change number",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                color: AppColor.shapesColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPinCodeContainer(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        length: 6,
        appContext: context,
        obscureText: false,
        animationType: AnimationType.scale,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Colors.blue[100],
            inactiveFillColor: AppColor.backgroundColor,
            borderWidth: 1,
            selectedFillColor: Colors.blue,
            inactiveColor: AppColor.shapesColor,
            activeColor: AppColor.iconsColor,
            selectedColor: AppColor.iconsColor),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: AppColor.backgroundColor,
        enableActiveFill: true,
        controller: textEditingController,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}