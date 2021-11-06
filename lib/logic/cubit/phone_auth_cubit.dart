import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/data/drop_down_menu.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  String countryKey;
  String verificationCode;
  Item selectedCountry;

  static PhoneAuthCubit get(context) => BlocProvider.of(context);
  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitUserPhoneNumber(String phoneNum) async {
    emit(PhoneAuthLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+2$phoneNum",
        verificationCompleted: verificationCompleted,
        timeout: const Duration(seconds: 15),
        verificationFailed: verificationFailed,
        codeSent: codeSentToUser,
        codeAutoRetrievalTimeout: (String verificationId) {
          print("codeAutoRetrievalTimeout : $verificationId");
        });
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print("verificationCompleted");
    await userSignIn(credential);
  }

  void verificationFailed(FirebaseAuthException exception) {
    print("verificationFailed : ${exception.toString()}");
    emit(PhoneAuthErrorOccured(message: exception.toString()));
  }

  void codeSentToUser(String verficationID, int reSentCode) {
    verificationCode = verficationID;
    emit(PhoneNumberSubmited());
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
      emit(PhoneAuthErrorOccured(message: error.toString()));
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
}
