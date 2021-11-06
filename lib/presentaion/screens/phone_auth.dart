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
                buildPhoneFormField(emailTextController),
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
      listenWhen: (previos, current) {
        return previos != current;
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showLoadingDialog(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          Navigator.of(context)
              .pushNamed(verifyPhoneScreen, arguments: phoneNumber);
        }
        if (state is PhoneAuthErrorOccured) {
          // Navigator.pop(context);
          String errorMesg = state.message;
          showFlushbar(context, errorMesg);
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

  Widget buildPhoneFormField(TextEditingController textEditingController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 60,
            padding: EdgeInsets.all(8),
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
                return Container(
                  height: 200,
                  child: DropdownButton<Item>(
                    hint: Text("Select item"),
                    value: PhoneAuthCubit.get(context).selectedCountry,
                    onChanged: (Item value) {
                      PhoneAuthCubit.get(context).selectedCountry = value;
                    },
                    items: items.map((Item user) {
                      return DropdownMenuItem<Item>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            user.icon,
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user.name,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
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
