import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_maps/data/user_model.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseAuthAppCubit extends Cubit<FirebaseAuthAppState> {
  String countryKey = "+20";
 late String verificationCode;

  static FirebaseAuthAppCubit get(context) => BlocProvider.of(context);

  FirebaseAuthAppCubit(): super(PhoneAuthInitial());

  //*** start user signIn with phone number ***//
  Future<void> submitUserPhoneNumber(String phoneNum) async {
    emit(PhoneAuthLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "$countryKey$phoneNum",
        verificationCompleted: verificationCompleted,
        timeout: const Duration(seconds: 25),
        verificationFailed: verificationFailed,
        codeSent: codeSentToUser,
        codeAutoRetrievalTimeout: (String verificationId) {

        });

  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    await userSignIn(credential);
  }

  void verificationFailed(FirebaseAuthException exception) {
    emit(PhoneAuthErrorOccurred(message: exception.toString()));
  }

  void codeSentToUser(String verificationID, int? reSentCode) {
    verificationCode = verificationID;
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

  //*** end user signIn with phone number ***//

  Future userSignOut() async {
    emit(UserSignOutLoading());
    await FirebaseAuth.instance.signOut().whenComplete(() {
      emit(UserSignOutSuccess());
    }).onError((error, stackTrace) {
      emit(UserSignUpError(errorMessage: error.toString()));
    });
  }

  Future userResetPassword(String email) async {
    emit(UserResetPasswordLoading());
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).whenComplete(() {
      emit(UserResetPasswordSuccess());
    }).onError((error, stackTrace) {
      emit(UserResetPasswordError(errorMessage: error.toString()));
    });
  }

  User? getUserInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  String getUserID() {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    return userID;
  }

   File? profileImage;
  final imagePicker = ImagePicker();
  Future<void> getProfileImage(BuildContext context) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(ChangeProfileImageSuccess());
      profileImage = File(pickedFile.path);
      uploadUserProfileImage(context);
    } else {
      showFlushBar(context, "No Image Selected .." , "Info");
      emit(ChangeProfileImageError(errorMessage: 'No Image Selected ..'));
    }
  }

  late UserModel userModel;
  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShowing = true;
  void changePasswordVisibility() {
    isPasswordShowing = !isPasswordShowing;
    suffix = isPasswordShowing
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(ChangePasswordVisibilityState());
  }

  String? signInType;
  Future userSignInWithGoogleAccount()async{
    final GoogleSignInAccount? signInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    emit(UserLoginLoadingState());
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      signInType = value.user!.email;
      emit(UserLoginSuccessState(userID: value.user!.uid));
    }).catchError((onError){
      emit(UserLoginErrorState(errorMessage: onError.toString()));
    });
  }

  Future signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    emit(UserLoginLoadingState());
    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).then((value){
      signInType = "Default";
      emit(UserLoginSuccessState(userID: value.user!.uid));
    }).catchError((onError){
      emit(UserLoginErrorState(errorMessage: onError.toString()));
    });
  }
  void userLogin({required String email, required String password}) {
    emit(UserLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(UserLoginSuccessState(userID: value.user!.uid));
    }).catchError((onError) {
      emit(UserLoginErrorState(errorMessage: onError.toString()));
    });
  }

  void userRegister(
      {required String name,
        required String phone,
        required String email,
        required String bio,
        required String password}) {
     emit(UserSignUpLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,).then((value) {
      createNewUser(id: value.user!.uid , name: name, phone: phone, email: email, password: password , bio: bio, profilePhoto: userModel.image);
      emit(UserSignUpSuccess());
    }).catchError((onError) {
     emit(UserSignUpError(errorMessage:onError.toString()));
    });
  }


  void uploadUserProfileImage(BuildContext context){
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
         userModel.image = value;
        emit(UploadUserProfileImageSuccess());
      }).catchError((onError) {
        emit(UploadUserProfileImageError(errorMessage: onError.toString()));
      });
    }).catchError((onError) {
      emit(UploadUserProfileImageError(errorMessage: onError.toString()));
    });
  }

  void createNewUser(
      {required String id,
        required String name,
        required String phone,
        required String email,
        required String profilePhoto , required String password , required String bio}) {
    emit(CreateNewUserLoading());

    userModel = UserModel(
        name: name, email: email, phone: phone, uId: id, image: profilePhoto , password: password , bio: bio);
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateNewUserSuccess());
    }).catchError((onError) {
      emit(CreateNewUserError(errorMessage: onError.toString()));
    });
  }

  void getCurrentUserInfo() {
    emit(GetUserInfoLoadingStatus());
    FirebaseFirestore.instance
        .collection('users')
        .doc(getUserID())
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserInfoSuccessStatus());
    }).catchError((onError) {
      emit(GetUserInfoErrorStatus(errorMessage: onError.toString()));
    });
  }

  void updateCurrentUser ({required String name, required String phone,required String email , required String bio}) async{
    emit(UpdateCurrentUserInfoLoading());
   userModel = UserModel(
        name: name, uId: getUserID(), email: email,phone: phone, image: userModel.image , bio: bio);
    FirebaseFirestore.instance
        .collection('users')
        .doc(getUserID())
        .update(userModel.toMap())
        .then((value) {
      getCurrentUserInfo();
      emit(UpdateCurrentUserInfoSuccess());
    }).catchError((onError) {
      emit(UpdateCurrentUserInfoError(errorMessage: onError.toString()));
    });
  }

  void updateInfo(TextEditingController name, TextEditingController email , TextEditingController phone , TextEditingController bio) {
    userModel.name = name.text;
    userModel.email = email.text;
    userModel.bio = bio.text;
    userModel.phone = phone.text;
    emit(UpdateUserInfo());
  }

}