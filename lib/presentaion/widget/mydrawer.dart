import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var userModel = PhoneAuthCubit.get(context).userModel;
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
            ),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                const SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                      radius: 75.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 75.0,
                          backgroundImage: AssetImage("assets/images/location.png"))),
                ),
                const SizedBox(height: 10,),
                Text(
                  "userModel.name",
                  style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: AppColor.textColor),
                ),
                const SizedBox(height: 10,),
                Text(
                  "userModel.phone",
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
          const SizedBox(height: 30,),
          buildTextViewShape(context: context, text: "My Profile", iconData: Icons.person),

          const SizedBox(height: 10,),
          buildTextViewShape(context: context, text: "Search History", iconData: Icons.history),

          const SizedBox(height: 10,),
          buildTextViewShape(context: context, text: "Help", iconData: Icons.info),

          const SizedBox(height: 10,),
          buildTextViewShape(context: context, text: "Logout", iconData: Icons.logout),

        ],
      ),
    );
  }

  Widget buildTextViewShape(
      {required BuildContext context, required String text, required IconData iconData}) {
    return Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(iconData , size: 30, color: text == "Logout" ? Colors.red : AppColor.textColor,),
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
        ));
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
