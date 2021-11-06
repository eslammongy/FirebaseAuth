import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/data/drop_down_menu.dart';
import 'package:flutter_maps/logic/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:flutter_maps/presentaion/widget/upper_view.dart';

// ignore: must_be_immutable
class PhoneAuthScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailTextController = TextEditingController();
  String phoneNumber;
  Item selectedUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                displayUpperView(
                    "What is your phone number?",
                    "Please enter your phone number to verify your account.",
                    ''),
                buildPhoneFormField(context, emailTextController),
                SizedBox(
                  height: 100,
                ),
                submitUserPhoneNumber(),
                buildButtonShape(
                    buttonWidth: 160.0,
                    buttonText: "Next",
                    context: context,
                    onPressed: () {
                      showLoadingDialog(context);
                      submitPhone(context);
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget submitUserPhoneNumber() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showLoadingDialog(context);
        }
        if (state is PhoneNumberSubmitted) {
          Navigator.pop(context);
          Navigator.of(context)
              .pushNamed(verifyPhoneScreen, arguments: phoneNumber);
        }
        if (state is PhoneAuthErrorOccurred) {
          Navigator.pop(context);
          String errorMeg = state.message;
          showFlushbar(context, errorMeg);
        }
      },
      child: Container(),
    );
  }

  Future<void> submitPhone(BuildContext context) async {
    if (!formKey.currentState.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      formKey.currentState.save();
      PhoneAuthCubit.get(context).submitUserPhoneNumber(phoneNumber);
    }
  }

  Widget buildPhoneFormField(
      BuildContext context, TextEditingController textEditingController) {
    var width = MediaQuery.of(context).size.width * 0.75;
    var height = MediaQuery.of(context).size.height * 0.65;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
              builder: (context, state) {
                return CountryCodePicker(
                  hideSearch: true,
                  onChanged: (code) {
                    PhoneAuthCubit.get(context).countryKey = code.dialCode;
                    print("****" + PhoneAuthCubit.get(context).countryKey);
                  },
                  initialSelection: 'EG',
                  favorite: ['+20', 'EG'],
                  dialogTextStyle:
                      TextStyle(fontSize: 15, color: AppColor.textColor),
                  textStyle: TextStyle(fontSize: 19, color: AppColor.textColor),
                  showCountryOnly: true,
                  dialogSize: Size(width, height),
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 7,
            child: textInputField(
                size: 60,
                controller: textEditingController,
                type: TextInputType.phone,
                validate: (String value) {
                  if (value.isEmpty) {
                    return "please enter phone number";
                  } else if (value.length < 11) {
                    return "too short for a phone number";
                  }
                  return null;
                },
                onSubmit: (value) {
                  phoneNumber = value;
                },
                label: "phone number",
                prefix: Icons.phone_android_rounded))
      ],
    );
  }
}
