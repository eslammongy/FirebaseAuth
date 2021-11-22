import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/button_shape.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/upper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class PhoneAuthScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textEditingController = TextEditingController();
  String? phoneNumber;

  PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, welcomeScreen);
                },
                icon: Icon(
                  FontAwesomeIcons.arrowAltCircleLeft,
                  size: 30,
                  color: CustomColors.colorGrey,
                ),
              ),
            ),
            displayUpperView(
                "What is your phone number?",
                "Please enter your phone number to verify your account.",
                ''),
            buildPhoneFormField(context, textEditingController),
            const SizedBox(
              height: 100,
            ),
            submitUserPhoneNumber(),
            buildButtonShape(
                buttonWidth: 160.0,
                buttonText: "Next",
                context: context,
                onPressed: () {
                  showLoadingDialog(context);
                  submitPhone(context);
                })
          ],
        ),
      ),
    ),
      ),
    );
  }

  Widget submitUserPhoneNumber() {
    return BlocListener<FirebaseAuthAppCubit, FirebaseAuthAppState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showLoadingDialog(context);
        }
        if (state is PhoneNumberSubmitted) {
          Navigator.pop(context);
          Navigator.of(context)
              .pushNamed(verifyPhoneScreen, arguments: phoneNumber);
        }
        if (state is PhoneAuthErrorOccurred) {
          Navigator.pop(context);
          String errorMeg = state.message;
          showFlushBar(context, errorMeg , "Error");
        }
      },
      child: Container(),
    );
  }

  Future<void> submitPhone(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      formKey.currentState!.save();
      FirebaseAuthAppCubit.get(context).submitUserPhoneNumber(phoneNumber!);
    }
  }

  Widget buildPhoneFormField(
      BuildContext context, TextEditingController textEditingController) {
    var width = MediaQuery.of(context).size.width * 0.75;
    var height = MediaQuery.of(context).size.height * 0.65;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        flex: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: BlocBuilder<FirebaseAuthAppCubit, FirebaseAuthAppState>(
            builder: (context, state) {
              return CountryCodePicker(
                hideSearch: true,
                onChanged: (code) {
                  FirebaseAuthAppCubit.get(context).countryKey = code.dialCode!;
                },
                initialSelection: 'EG',
                favorite: const ['+20', 'EG'],
                dialogTextStyle:
                    TextStyle(fontSize: 15, color: AppColor.textColor),
                textStyle: TextStyle(fontSize: 19, color: AppColor.textColor),
                showCountryOnly: true,
                dialogSize: Size(width, height),
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              );
            },
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        flex: 7,
        child: Container(
          height: 70,
          padding: const EdgeInsets.all(10),
          decoration:  BoxDecoration(
            color: CustomColors.colorGrey,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: TextFormField(
            controller: textEditingController,
            autofocus: true,
            style: const TextStyle(
              fontSize: 22,
              letterSpacing: 2.0,
            ),
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                    maxHeight: double.infinity, maxWidth: double.infinity),
                border: InputBorder.none),
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter you phone number!';
              } else if (value.length < 11) {
                return 'Too short for a phone number!';
              }
              return null;
            },
            onSaved: (value) {
              phoneNumber = value!;
            },
          ),
        ),
      ),
    ]);
  }
}
