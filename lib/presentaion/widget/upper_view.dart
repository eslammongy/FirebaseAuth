import 'package:flutter/cupertino.dart';
import 'package:flutter_maps/constants/colors.dart';

Widget displayUpperView(String text1, String text2) {
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
      Text(
        text2,
        style: TextStyle(
            fontSize: 20,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            color: AppColor.textColor),
      ),
      SizedBox(
        height: 70,
      ),
    ],
  );
}
