import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/data/user_model.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
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
    await FirebaseAuth.instance.signOut();
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
    } else {
      showFlushBar(context, "No Image Selected ..");
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

    emit(UserChangePasswordVisibilityState());
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
        required String password}) {
     emit(UserSignUpLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,).then((value) {
      createNewUser(uId: value.user!.uid, name: name, phone: phone, email: email, password: password);
      emit(UserSignUpSuccess());
    }).catchError((onError) {
     emit(UserSignUpError(errorMessage:onError.toString()));
    });
  }

  void setUserInfo(
      {required String id,
        required String name,
        required String phone,
        required String email,
        required String profilePhoto , required String password}) {
    emit(CreateNewUserLoading());

    userModel = UserModel(
        name: name, email: email, phone: phone, uId: id, image: profilePhoto , password: password);
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

  void createNewUser(
      {required String uId , required String name, required String phone, required String email , required String password}) {

    FirebaseStorage.instance
        .ref()
        .child('users/$name/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        setUserInfo(
            id: uId,
            name: name,
            phone: phone,
            email: email,
            profilePhoto: value , password: password);
        emit(UploadUserProfileImageSuccess());
      }).catchError((onError) {
        emit(UploadUserProfileImageError(errorMessage: onError.toString()));
      });
    }).catchError((onError) {
      emit(UploadUserProfileImageError(errorMessage: onError.toString()));
    });
  }

  void getCurrentUserInfo() {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    emit(GetUserInfoLoadingStatus());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserInfoSuccessStatus());
    }).catchError((onError) {
      emit(GetUserInfoErrorStatus(errorMessage: onError.toString()));
    });
  }

  void updateCurrentUser (
      {required String name, required String phone,required String email , required String? profileImage}) async{
    UserModel user = UserModel(
        name: name, uId: getUserID(), email: email,phone: phone, image: profileImage ?? userModel.image);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(user.toMap())
        .then((value) {
      getCurrentUserInfo();
    }).catchError((onError) {});
  }

  void updateCurrentUserFullInfo(
      {required String name, required String email  ,required String phone}) {
    emit(UpdateCurrentUserInfoLoading());
    FirebaseStorage.instance
        .ref()
        .child('users/$name/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) => value.ref.getDownloadURL().then((value) {
      updateCurrentUser(
          name: name, phone: phone , email: email ,profileImage: value);
      emit(UpdateCurrentUserInfoSuccess());
    }).catchError((onError) {
      emit(UpdateCurrentUserInfoError(errorMessage: onError.toString()));
    }))
        .catchError((onError) {
      emit(UpdateCurrentUserInfoError(errorMessage: onError.toString()));
    });
  }

  void updateInfo(TextEditingController name, TextEditingController email) {
    userModel.name = name.text;
    userModel.email = email.text;
    emit(UpdateUserInfo());
  }
}