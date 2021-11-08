import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              Stack(alignment: AlignmentDirectional.topCenter, children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("assets/images/maps_image.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/correction.png",
                  width: 180,
                  height: 180,
                ),
              ]),
              Spacer(),
              Text(
                "You're almost done to get started, let's do it...",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w800,
                    color: AppColor.textColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: AppColor.shapesColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 3),
                      )
                    ]),
                child: TextButton(
                    onPressed: () {
                     showLoadingDialog(context);
                     PhoneAuthCubit.get(context).getCurrentUserInfo();
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
              ),
              getUserStates()
            ],
          ),
        ),
      ),
    );
  }

  Widget getUserStates() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is GetUserInfoLoadingStatus) {
          showLoadingDialog(context);
        }
        if (state is GetUserInfoSuccessStatus) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(userProfileScreen);
        }
        if (state is GetUserInfoErrorStatus) {
          Navigator.pop(context);
          String errorMeg = state.errorMessage;
          showFlushbar(context, errorMeg);
        }
      },
      child: Container(),
    );

  }
}
