import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';

// ignore: must_be_immutable
class CreateUserAccount extends StatelessWidget {
  var eTextNameController = TextEditingController();
  var eTextEmailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final String phoneNumber;

  CreateUserAccount({Key key , @required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            "What about you?",
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
                                fontSize: 18,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                color: AppColor.textColor),
                          ),

                          SizedBox(height: 30),
                          Center(child: BlocBuilder<PhoneAuthCubit,
                              PhoneAuthState>(
                              builder: (context, state) {
                                var profileImage = PhoneAuthCubit
                                    .get(context)
                                    .profileImage;
                                return Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      CircleAvatar(
                                        radius: 68.0,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                            radius: 65.0,
                                            backgroundImage: profileImage ==
                                                null
                                                ? NetworkImage(
                                                "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png")
                                                : FileImage(profileImage)),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          PhoneAuthCubit.get(context)
                                              .getProfileImage(context);
                                        },
                                        icon: CircleAvatar(
                                            backgroundColor: AppColor
                                                .backgroundColor,
                                            radius: 30,
                                            child: Icon(
                                              Icons.camera_alt_rounded,
                                              size: 20,
                                            )),
                                      ),
                                    ]);
                              })),
                          SizedBox(
                            height: 40,
                          ),
                          textInputField(
                              controller: eTextNameController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "please enter your name !";
                                }
                              },
                              label: "full name",
                              prefix: Icons.person),
                          SizedBox(
                            height: 20,
                          ),
                          textInputField(
                              controller: eTextEmailController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "please enter your name !";
                                }
                              },
                              label: "email",
                              prefix: Icons.email_rounded),
                          SizedBox(
                            height: 60,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: "By registering you agree to ",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "Roboto",
                                          height: 1.5,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.textColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Terms & Conditions",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
                                                color: AppColor.shapesColor)),
                                        TextSpan(
                                            text: " and ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: "Roboto",
                                                height: 1.5,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.textColor)),
                                        TextSpan(
                                            text: "Privacy Policy",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
                                                color: AppColor.shapesColor)),
                                        TextSpan(
                                            text: " of the app ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: "Roboto",
                                                height: 1.5,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.textColor))
                                      ]),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: AppColor.shapesColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
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
                                        createUserAccount(context);

                                      },
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      )),
                                ),
                                createUserStates(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        }

  Widget createUserStates() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is CreateNewUserLoading) {
            showLoadingDialog(context);
          }
          if (state is CreateNewUserSuccess) {
            Navigator.pop(context);
            Navigator.of(context)
                .pushNamed(wellDoneScreen , arguments: phoneNumber);
          }
          if (state is CreateNewUserError) {
            Navigator.pop(context);
            String errorMeg = state.errorMessage;
            showFlushbar(context, errorMeg);
          }
        },
        child: Container(),
    );

  }
  void createUserAccount(BuildContext context){
    if (!formKey.currentState.validate()) {
      Navigator.pop(context);
      return;
    } else {
      formKey.currentState.save();
      PhoneAuthCubit.get(context)
          .createNewUser(
          name: eTextNameController.text,
          phone: phoneNumber,
          email: eTextEmailController.text);
    }
  }

  }



