import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/images/correction.png",
                width: 180,
                height: 180,
              ),
              Spacer(),
              Text(
                "You're almost done to get started, let's do it...",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    color: AppColor.textColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 15),
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
                      "Done",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
