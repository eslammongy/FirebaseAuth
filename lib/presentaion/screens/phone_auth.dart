import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/data/drop_down_menu.dart';
import 'package:flutter_maps/presentaion/screens/Verify_phone_number.dart';
import 'package:flutter_maps/presentaion/screens/create_user_account.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:flutter_maps/presentaion/widget/upper_view.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
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
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayUpperView(
                    "What is your phone number?",
                    "Please enter your phone number to verify your account.",
                    ''),
                buildPhoneFormField(selectedUser, emailTextController),
                SizedBox(
                  height: 80,
                ),
                buildButtonShape(
                    buttonText: "Next",
                    context: context,
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(verifyPhoneScreen);
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildPhoneFormField(
      Item seletedItem, TextEditingController textEditingController) {
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
            child: DropdownButton<Item>(
              hint: Text("Select item"),
              value: selectedUser,
              onChanged: (Item value) {
                setState(() {
                  selectedUser = value;
                });
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
