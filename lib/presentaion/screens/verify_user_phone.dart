import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/upper_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class VerifyPhoneNumber extends StatelessWidget {
  var textEditingController = TextEditingController();
  final String phoneNumber;
  late String otpCode;

  VerifyPhoneNumber({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          displayUpperView(
              "Verify your phone number",
              "Enter your 6 digit code numbers sent to you at",
              phoneNumber),
          buildPinCodeContainer(context),
          const SizedBox(
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
          verifiedUserPhoneNumber(),
          const SizedBox(
            height: 90,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't’t receive a verification code?",
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      color: CustomColors.colorGrey),
                ),
                const SizedBox(
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
                          color: CustomColors.colorAmber),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      width: 2,
                      color: CustomColors.colorGrey,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      " Change number",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: CustomColors.colorAmber),
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
    );
  }

  Widget verifiedUserPhoneNumber() {
    return BlocListener<FirebaseAuthAppCubit, FirebaseAuthAppState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showLoadingDialog(context);
        }
        if (state is PhoneOtpCodeVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(createAccountScreen , arguments: phoneNumber);
        }
        if (state is PhoneAuthErrorOccurred) {
          Navigator.pop(context);
          String errorMessage = state.message;
          showFlushBar(context, errorMessage , "Error");
        }
      },
      child: Container(),
    );
  }

  void signInWithPhoneNumber(BuildContext context) {
    FirebaseAuthAppCubit.get(context).submitOtbCode(otpCode);
  }

  Widget buildPinCodeContainer(BuildContext context) {
    return PinCodeTextField(
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
          inactiveFillColor: CustomColors.colorGrey,
          borderWidth: 1,
          selectedFillColor: CustomColors.googleBackground,
          inactiveColor: CustomColors.colorAmber,
          activeColor:CustomColors.colorAmber,
          selectedColor: CustomColors.colorYellow),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: CustomColors.backgroundColor,
      enableActiveFill: true,
      controller: textEditingController,
      onCompleted: (code) {
        otpCode = code;
      },
      onChanged: (value) {
      },
    );
  }
}
