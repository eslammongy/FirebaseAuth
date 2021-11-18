import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class UserRegistrationScreen extends StatelessWidget {
  var etNameController = TextEditingController();
  var etEmailController = TextEditingController();
  var etPhoneController = TextEditingController();
  var etPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              autovalidate: true,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, userLoginScreen);
                        },
                        icon: Icon(
                          FontAwesomeIcons.arrowAltCircleLeft,
                          size: 30,
                          color: CustomColors.colorGrey,
                        ),
                      ),
                    ),
                    BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
                        builder: (context, state) {
                      var profileImage =
                          PhoneAuthCubit.get(context).profileImage;
                      return Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              child: profileImage == null
                                  ? const CircleAvatar(
                                      radius: 55.0,
                                      backgroundImage: NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/1177/1177568.png"))
                                  : CircleAvatar(
                                      radius: 55.0,
                                      backgroundImage: FileImage(profileImage)),
                            ),
                            IconButton(
                              onPressed: () {
                                PhoneAuthCubit.get(context)
                                    .getProfileImage(context);
                              },
                              icon: CircleAvatar(
                                  backgroundColor: AppColor.backgroundColor,
                                  radius: 30,
                                  child: const Icon(
                                    FontAwesomeIcons.arrowAltCircleUp,
                                    size: 20,
                                  )),
                            ),
                          ]);
                    }),
                    const SizedBox(height: 20),
                    Text(
                      "Create an account, for free😊",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: CustomColors.colorYellow),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textInputFormField(
                        textEditingController: etNameController,
                        label: "enter your name",
                        prefix: const Icon(FontAwesomeIcons.userAlt),
                        textSize: 20.0,
                        textInputType: TextInputType.name,
                        autoFocus: false),
                    const SizedBox(
                      height: 20,
                    ),
                    textInputFormField(
                        textEditingController: etEmailController,
                        label: "enter your email",
                        prefix: const Icon(Icons.email),
                        textSize: 20.0,
                        textInputType: TextInputType.emailAddress,
                        autoFocus: false),
                    const SizedBox(
                      height: 20,
                    ),
                    textInputFormField(
                        textEditingController: etPhoneController,
                        label: "enter your phone",
                        prefix: const Icon(FontAwesomeIcons.phoneAlt),
                        textSize: 20.0,
                        textInputType: TextInputType.phone,
                        autoFocus: false),
                    const SizedBox(
                      height: 20,
                    ),
                    textInputFormField(
                        textEditingController: etPasswordController,
                        label: "enter your password",
                        prefix: const Icon(FontAwesomeIcons.lock),
                        textSize: 20.0,
                        textInputType: TextInputType.visiblePassword,
                        autoFocus: false),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CustomColors.colorOrange,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                )
                              ]),
                          child: TextButton(
                              onPressed: () {
                                showLoadingDialog(context);
                                createUserAccount(context);
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: CustomColors.colorYellow),
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, userRegistrationScreen);
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.colorAmber),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        createUserStates(),
                      ],
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
        if (state is UserSignUpLoading) {
          showLoadingDialog(context);
        }
        if (state is UserSignUpSuccess) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(userLoginScreen);
        }
        if (state is UserSignUpError) {
          Navigator.pop(context);
          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg);
        }
      },
      child: Container(),
    );
  }

  void createUserAccount(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      formKey.currentState!.save();
      PhoneAuthCubit.get(context).userRegister(
          name: etNameController.text,
          phone: etPhoneController.text,
          email: etEmailController.text , password: etPasswordController.text);
    }
  }

}
