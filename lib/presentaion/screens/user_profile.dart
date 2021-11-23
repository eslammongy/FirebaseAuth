import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/icon_broken.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/data/user_model.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/displaying_edit_dialog.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  var etNameController = TextEditingController();
  var etEmailController = TextEditingController();
  var etPhoneController = TextEditingController();
  var etBioController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String signInType;
   UserProfileScreen({Key? key , required this.signInType}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    FirebaseAuthAppCubit
        .get(context)
        .userModel = UserModel(name: '', uId: '', phone: '', email: '', image: '' , bio: "");
    FirebaseAuthAppCubit.get(context).getCurrentUserInfo();
   print("&&&&&&& $signInType");
    return BlocConsumer<FirebaseAuthAppCubit, FirebaseAuthAppState>(
      listener: (context, state) {
        if (state is GetUserInfoErrorStatus) {
          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg , "Error");
        }
      },
      builder: (context, state) {

        var userModel = FirebaseAuthAppCubit
            .get(context)
            .userModel;
        return Scaffold(
            backgroundColor: CustomColors.backgroundColor,
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    if(state is UpdateCurrentUserInfoLoading)
                      LinearProgressIndicator(
                        minHeight: 10,
                        color: CustomColors.googleBackground, backgroundColor: CustomColors.colorOrange,),
                    if(state is GetUserInfoLoadingStatus)
                      LinearProgressIndicator(
                        minHeight: 10,
                        color: CustomColors.googleBackground, backgroundColor: CustomColors.colorOrange,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: IconButton(
                            onPressed: () {
                             FirebaseAuthAppCubit.get(context).userSignOut();
                            },
                            icon: const Icon(
                              Icons.logout,
                              size: 30,
                              color: Colors.red,
                            ),),
                          ),
                        const  Spacer(),
                        Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)),
                               ),
                            child: IconButton(
                                onPressed: () {
                                  if(signInType == "Default"){
                                    showingGeneralDialog(context , "Default");
                                  }else if(signInType.contains(RegExp(emailPattern))){
                                    showingGeneralDialog(context, "Email");
                                  }else if(signInType.contains(RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)'))){
                                    showingGeneralDialog(context, "Phone");
                                  }

                                },
                                icon: Icon(
                                  Icons.edit_road_outlined,
                                  color: AppColor.backgroundColor,
                                ))),
                      ],
                    ),

                    BlocBuilder<FirebaseAuthAppCubit, FirebaseAuthAppState>(
                        builder: (context, state) {
                          var profileImage = FirebaseAuthAppCubit
                              .get(context)
                              .profileImage;
                          return Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  child: profileImage == null
                                      ?   CircleAvatar(
                                          radius: 60.0,
                                          backgroundImage: NetworkImage(userModel.image.isEmpty ? "https://cdn-icons-png.flaticon.com/512/1177/1177568.png" : userModel.image))
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
                                        FontAwesomeIcons.arrowAltCircleUp,
                                        size: 20,
                                      )),
                                ),
                              ]);
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    buildTextViewShape(context, userModel.name , 20,false , FontAwesomeIcons.userAlt),
                    const SizedBox(
                      height: 15,
                    ),
                    buildTextViewShape(context, userModel.phone ,20 ,false , FontAwesomeIcons.phoneSquare),
                    const SizedBox(
                      height: 15,
                    ),
                    buildTextViewShape(context, userModel.email , 18 ,false , Icons.email),
                    const SizedBox(
                      height: 15,
                    ),
                    buildTextViewShape(context, userModel.bio ,18 ,true , FontAwesomeIcons.infoCircle),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: buildButtonShape(
                          buttonText: "Update",
                          buttonWidth: double.infinity,
                          context: context,
                          onPressed: () {
                              FirebaseAuthAppCubit.get(context).updateCurrentUser(
                                  name: userModel.name , email: userModel.email , phone: userModel.phone , bio: userModel.bio
                              );
                          }),
                    ),
                    createUserStates()
                  ],
                ),
              ),
            ));
      });
  }


  Widget buildTextViewShape(BuildContext context, String text ,double textSize ,bool isTextBio , IconData iconData) {
    return Container(
        width: double.infinity,
        height: isTextBio ? 160 : 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: HexColor("2C313C"),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: CustomColors.googleBackground,
            width: 1,
          ),
        ),
        child: Align(
          alignment: isTextBio ? AlignmentDirectional.topStart : AlignmentDirectional.centerStart ,
          child: Row(
            children: [
              const SizedBox(width: 5,),
              Icon(iconData , size: 22, color: CustomColors.colorAmber),
              const SizedBox(width: 5,),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                      fontSize: textSize,
                      letterSpacing: isTextBio ? -0.5 : 1.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: CustomColors.colorGrey),
                ),
              ),
            ],
          ),
        ));
  }

  Widget createUserStates() {
    return BlocListener<FirebaseAuthAppCubit, FirebaseAuthAppState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is UserSignOutLoading) {
          Navigator.pop(context);
          showLoadingDialog(context);
        }
        if (state is UserSignOutSuccess) {
          Navigator.pushReplacementNamed(context, welcomeScreen);
          showFlushBar(context, "Sign Out Finished Successfully" , "Error");
        }
        if (state is UserLoginErrorState) {
          Navigator.pop(context);
          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg , "Error");
        }
        if(state is UploadUserProfileImageSuccess){
          showFlushBar(context, "Your Profile Photo Uploaded Successfully." , "Info");
        }
      },
      child: Container(),
    );
  }
}
