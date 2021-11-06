import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/upper_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class VerifyPhoneNumber extends StatelessWidget {
  var textEditingController = TextEditingController();
  final String phoneNumber;
  String otpCode;
  VerifyPhoneNumber({Key key, @required this.phoneNumber}) : super(key: key);
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
                    "$phoneNumber"),
                buildPinCodeContainer(context),
                SizedBox(
                  height: 40,
                ),
                buildButtonShape(
                    buttonWidth: 160.0,
                    buttonText: "Verify",
                    context: context,
                    onPressed: () {
                      showLoadingDialog(context);
                      signInWithPhoneNumber(context);
                    }),
                verifiyUserPhoneNumber(),
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

  Widget verifiyUserPhoneNumber() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previos, current) {
        return previos != current;
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showLoadingDialog(context);
        }
        if (state is PhoneOtpCodeVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(createAccountScreen);
        }
        if (state is PhoneAuthErrorOccured) {
          String errorMesg = state.message;
          showFlushbar(context, errorMesg);
        }
      },
      child: Container(),
    );
  }

  void signInWithPhoneNumber(BuildContext context) {
    PhoneAuthCubit.get(context).submitOtbCode(otpCode);
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
        onCompleted: (code) {
          otpCode = code;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}
