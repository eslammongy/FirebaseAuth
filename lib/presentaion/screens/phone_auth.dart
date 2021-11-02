import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/data/drop_down_menu.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';

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
                Center(
                  child: Image.asset(
                    "assets/images/location.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "What is your phone number?",
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
                      fontSize: 20,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      color: AppColor.textColor),
                ),
                SizedBox(
                  height: 80,
                ),
                buildPhoneFormField(seletedItem, emailTextController),
                SizedBox(
                  height: 80,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        color: AppColor.iconsColor,
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
                          "Next",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
