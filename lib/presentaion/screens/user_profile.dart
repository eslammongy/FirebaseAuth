import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/logic/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:hexcolor/hexcolor.dart';

class UserProfileScreen extends StatelessWidget {
  var eTextNameController = TextEditingController();
  var eTextEmailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = PhoneAuthCubit.get(context).userModel;
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state is UpdateCurrentUserInfoLoading) {
          showLoadingDialog(context);
        }
        if (state is UpdateCurrentUserInfoSuccess) {
          Navigator.pop(context);
        }
        if (state is UpdateCurrentUserInfoError) {
          Navigator.pop(context);
          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg);
        }
      },
      builder: (context, state) => Scaffold(
          backgroundColor: HexColor("DEDEDE"),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: IconButton(
                      onPressed: () {},
                      icon: CircleAvatar(
                          backgroundColor: AppColor.backgroundColor,
                          radius: 30,
                          child: Icon(
                            Icons.arrow_back,
                            size: 25,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
                      builder: (context, state) {
                    var profileImage = PhoneAuthCubit.get(context).profileImage;
                    return Center(
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                          CircleAvatar(
                            radius: 68.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(userModel.image)
                                    : FileImage(profileImage)),
                          ),
                          IconButton(
                            onPressed: () {
                              PhoneAuthCubit.get(context)
                                  .getProfileImage(context);
                            },
                            icon: CircleAvatar(
                                backgroundColor: AppColor.backgroundColor,
                                radius: 30,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20,
                                )),
                          ),
                        ]));
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 100),
                      decoration: BoxDecoration(
                          color: AppColor.shapesColor,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: IconButton(
                          onPressed: () {
                            showEditingInfoDialog(context);
                          },
                          icon: Icon(
                            Icons.edit_road_outlined,
                            color: AppColor.backgroundColor,
                          ))),
                  SizedBox(
                    height: 50,
                  ),
                  buildTextViewShape(context, userModel.name),
                  SizedBox(
                    height: 15,
                  ),
                  buildTextViewShape(context, userModel.phone),
                  SizedBox(
                    height: 15,
                  ),
                  buildTextViewShape(context, userModel.email),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        color: AppColor.shapesColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: TextButton(
                        onPressed: () {
                          PhoneAuthCubit.get(context).updateCurrentUserFullInfo(
                              name: userModel.name,
                              phone: userModel.phone,
                              email: userModel.email);
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildTextViewShape(BuildContext context, String text) {
    return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(
            color: AppColor.backgroundColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22,
                letterSpacing: 1.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
                color: AppColor.textColor),
          ),
        ));
  }
}
