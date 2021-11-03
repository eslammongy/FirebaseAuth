import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/presentaion/screens/create_user_account.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:flutter_maps/presentaion/widget/upper_view.dart';

class VerifyPhoneNumber extends StatelessWidget {
  VerifyPhoneNumber({Key key}) : super(key: key);
  var textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayUpperView("Verify your phone number",
                    "Enter your 6 digit code numbers sent to you at +20123456789"),
                textInputField(
                    controller: textEditingController,
                    type: TextInputType.phone,
                    validate: (_) {},
                    label: "phone number",
                    prefix: Icons.phone_android_rounded),
                SizedBox(
                  height: 40,
                ),
                buildButtonShape("Verify", context, CreateUserAccount()),
                SizedBox(
                  height: 60,
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
          )),
        ),
      ),
    );
  }
}
