import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/data/drop_down_menu.dart';
import 'package:flutter_maps/presentaion/screens/Verify_phone_number.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:flutter_maps/presentaion/widget/upper_view.dart';

class PhoneAuthScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailTextController = TextEditingController();

  DropDwonItem seletedItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: UniqueKey(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayUpperView("What is your phone number?",
                    "Please enter your phone number to verify your account."),
                buildPhoneFormField(seletedItem, emailTextController),
                SizedBox(
                  height: 80,
                ),
                buildButtonShape("Next", context, VerifyPhoneNumber())
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
