import 'package:flutter/cupertino.dart';
import 'package:flutter_maps/constants/colors.dart';

Widget displayUpperView(String text1, String text2, String phoneNumber) {
  return Column(
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
        text1,
        style: TextStyle(
            fontSize: 25,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w800,
            color: AppColor.textColor),
      ),
      SizedBox(
        height: 15,
      ),
      Container(
        child: phoneNumber.isEmpty
            ? Text(
                text2,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    color: AppColor.textColor),
              )
            : RichText(
                text: TextSpan(
                    text: "Enter your 6 digit code numbers sent to you at ",
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: "Roboto",
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: "$phoneNumber",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              color: AppColor.shapesColor))
                    ]),
              ),
      ),
      SizedBox(
        height: 70,
      ),
    ],
  );
}