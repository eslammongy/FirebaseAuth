import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/data/user_model.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  String countryKey = "+20";
  String verificationCode;

  static PhoneAuthCubit get(context) => BlocProvider.of(context);

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitUserPhoneNumber(String phoneNum) async {
    emit(PhoneAuthLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "$countryKey$phoneNum",
        verificationCompleted: verificationCompleted,
        timeout: const Duration(seconds: 15),
        verificationFailed: verificationFailed,
        codeSent: codeSentToUser,
        codeAutoRetrievalTimeout: (String verificationId) {
          print("codeAutoRetrievalTimeout : $verificationId");
        });

    print("*** $countryKey$phoneNum *********");
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print("verificationCompleted");
    await userSignIn(credential);
  }

  void verificationFailed(FirebaseAuthException exception) {
    print("verificationFailed : ${exception.toString()}");
    emit(PhoneAuthErrorOccurred(message: exception.toString()));
  }

  void codeSentToUser(String verficationID, int reSentCode) {
    verificationCode = verficationID;
    emit(PhoneNumberSubmitted());
  }

  Future<void> submitOtbCode(String otpCode) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationCode, smsCode: otpCode);

    await userSignIn(phoneAuthCredential);
  }

  Future<void> userSignIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOtpCodeVerified());
    } catch (error) {
      emit(PhoneAuthErrorOccurred(message: error.toString()));
    }
  }

  // ignore: missing_return
  Future<Void> userSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getUserInfo() {
    User user = FirebaseAuth.instance.currentUser;
    return user;
  }

  File profileImage;
  final imagePicker = ImagePicker();

  Future<void> getProfileImage(BuildContext context) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ChangeProfileImageSuccess());
    } else {
      print("No Image Selected ..");
      showFlushbar(context, "No Image Selected ..");
      emit(ChangeProfileImageError());
    }
  }

  void createNewUser(
      {@required String name,
      @required String phone,
      @required String email}) {

    emit(CreateNewUserLoading());
    var userID = FirebaseAuth.instance.currentUser.uid;
    UserModel userModel = UserModel(
        name: name, email: email, phone: phone, uId: userID, image: "eww");

    print("UserID : $userID");
    FirebaseFirestore.instance.collection("users")
    .doc(userID)
    .set(userModel.toMap())
    .then((value) {
      emit(CreateNewUserSuccess());
    }).catchError((onError){
      print(onError.toString());
      emit(CreateNewUserError(errorMessage: onError.toString()));
    });

  }
}
