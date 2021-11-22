import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/data/user_model.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CreateUserAccount extends StatelessWidget {
  var etNameController = TextEditingController();
  var etEmailController = TextEditingController();
  var etBioController = TextEditingController();
  var etPhoneController = TextEditingController();
  var etPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String phoneNumber;

  CreateUserAccount({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuthAppCubit
        .get(context)
        .userModel = UserModel(name: '', uId: '', phone: '', email: '', image: '' , bio: "");
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  Text(
                    "What about you?",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800,
                        color: CustomColors.colorGrey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Center(child: BlocBuilder<FirebaseAuthAppCubit, FirebaseAuthAppState>(
                      builder: (context, state) {
                    var profileImage =
                        FirebaseAuthAppCubit.get(context).profileImage;
                    return Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.white,
                            child: profileImage == null
                                ? const CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage(
                                        "https://cdn-icons-png.flaticon.com/512/1177/1177568.png"))
                                : CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: FileImage(profileImage)),
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseAuthAppCubit.get(context)
                                  .getProfileImage(context);
                            },
                            icon: CircleAvatar(
                                backgroundColor: AppColor.backgroundColor,
                                radius: 30,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20,
                                )),
                          ),
                        ]);
                  })),
                  const SizedBox(
                    height: 40,
                  ),
                  textInputFormField(
                      textEditingController: etNameController,
                      label: "enter your name",
                      prefix: const Icon(FontAwesomeIcons.userAlt),
                      textSize: 20.0,
                      isTextBio: false,
                      isTextPassword:false,
                      textInputType: TextInputType.name,
                      autoFocus: false),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: phoneNumber.length > 15 ? textInputFormField(
                      textEditingController: etPhoneController,
                      label: "enter your phone",
                      prefix: const Icon(FontAwesomeIcons.phoneAlt),
                      textSize: 20.0,
                      isTextBio: false,
                      isTextPassword:false,
                      textInputType: TextInputType.phone,
                      autoFocus: false) :textInputFormField(
                        textEditingController: etEmailController,
                        label: "enter your email",
                        prefix: const Icon(Icons.email),
                        textSize: 20.0,
                        isTextBio: false,
                        isTextPassword:false,
                        textInputType: TextInputType.emailAddress,
                        autoFocus: false),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: phoneNumber=="Facebook" ? textInputFormField(
                        textEditingController: etPhoneController,
                        label: "enter your phone",
                        prefix: const Icon(FontAwesomeIcons.phoneAlt),
                        textSize: 20.0,
                        isTextBio: false,
                        isTextPassword:false,
                        textInputType: TextInputType.phone,
                        autoFocus: false) :const SizedBox(
                      height: 0.5,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),

                  textInputFormField(
                      textEditingController: etBioController,
                      label: "enter your bio",
                      prefix: const Icon(FontAwesomeIcons.infoCircle),
                      textSize: 18.0,
                      isTextBio: true,
                      isTextPassword:false,
                      textInputType: TextInputType.text,
                      autoFocus: false),
                  const SizedBox(
                    height: 30,
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
                                  color: CustomColors.colorGrey),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Terms & Conditions",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: CustomColors.colorOrange)),
                                TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: "Roboto",
                                        height: 1.5,
                                        fontWeight: FontWeight.w400,
                                        color: CustomColors.colorGrey)),
                                TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: CustomColors.colorOrange)),
                                TextSpan(
                                    text: " of the app ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: "Roboto",
                                        height: 1.5,
                                        fontWeight: FontWeight.w400,
                                        color: CustomColors.colorGrey))
                              ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColor.shapesColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          child: TextButton(
                              onPressed: () {
                                showLoadingDialog(context);
                                if(phoneNumber.length > 12){
                                  FirebaseAuthAppCubit.get(context).createNewUser(
                                    id: FirebaseAuthAppCubit.get(context).getUserID(),
                                    name: etNameController.text,
                                    phone: etPhoneController.text, email: FirebaseAuthAppCubit.get(context).googleAccount!,
                                    profilePhoto: FirebaseAuthAppCubit.get(context).userModel.image,
                                    password: "password", bio: etBioController.text,);
                                }else if(phoneNumber.length > 12){
                                  FirebaseAuthAppCubit.get(context).createNewUser(
                                    id: FirebaseAuthAppCubit.get(context).getUserID(),
                                    name: etNameController.text,
                                    phone: phoneNumber, email: etEmailController.text,
                                    profilePhoto: FirebaseAuthAppCubit.get(context).userModel.image,
                                    password: "password", bio: etBioController.text,);
                                }else{
                                  FirebaseAuthAppCubit.get(context).createNewUser(
                                    id: FirebaseAuthAppCubit.get(context).getUserID(),
                                    name: etNameController.text,
                                    phone: etPhoneController.text, email: etEmailController.text,
                                    profilePhoto: FirebaseAuthAppCubit.get(context).userModel.image,
                                    password: "password", bio: etBioController.text,);
                                }
                              },
                              child: const Text(
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
    );
  }

  Widget createUserStates() {
    return BlocListener<FirebaseAuthAppCubit, FirebaseAuthAppState>(
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
              .pushReplacementNamed(userProfileScreen);
        }
        if (state is CreateNewUserError) {
          Navigator.pop(context);
          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg , "Error");
        }
      },
      child: Container(),
    );
  }


}
