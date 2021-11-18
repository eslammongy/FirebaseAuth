import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = PhoneAuthCubit.get(context).userModel;
    return Drawer(
     backgroundColor: AppColor.backgroundColor,
      child: Column(
        children: [
          Container(

            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.iconsColor,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),
               boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 3),
                )],
            ),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                 SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    radius: 68.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius: 65.0,
                        backgroundImage: NetworkImage(userModel.image))
                       ),
                  ),
                const SizedBox(height: 10,),
                Text(
                  userModel.name,
                  style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: AppColor.textColor),
                ),
                const SizedBox(height: 10,),
                Text(
                  userModel.phone,
                  style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: AppColor.textColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50,),
          buildTextViewShape(context: context, text: "My Profile", iconData: FontAwesomeIcons.solidUser , onTap: (){
            Navigator.of(context).pushNamed(userProfileScreen);
          }),

          const SizedBox(height: 10,),
          buildTextViewShape(context: context, text: "Search History", iconData:  FontAwesomeIcons.history),

          const SizedBox(height: 10,),
          buildTextViewShape(context: context, text: "Help", iconData:  FontAwesomeIcons.infoCircle),

          const SizedBox(height: 10,),
          buildTextViewShape(context: context, text: "Logout", iconData: FontAwesomeIcons.signOutAlt , onTap: (){
            PhoneAuthCubit.get(context).userSignOut();
            Navigator.of(context).pushReplacementNamed(phoneAuthScreen);
          }),

        ],
      ),
    );
  }

  Widget buildTextViewShape(
      {required BuildContext context, required String text, required IconData? iconData , Function()? onTap}) {
    return InkWell(
      child: Container(
          width: double.infinity,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(iconData , size: 22, color: text == "Logout" ? Colors.red : AppColor.textColor,),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      text,
                      style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: AppColor.textColor),
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded, size: 25, color: AppColor.iconsColor,),
                ],
              ),
              buildDivider()
            ],
          )),
      onTap: onTap,
    );
  }
   Widget buildDivider(){
    return  Container(  width: double.infinity,
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColor.textColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),

      ),);
   }
}
