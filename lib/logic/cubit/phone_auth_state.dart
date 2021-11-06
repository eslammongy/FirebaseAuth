part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthErrorOccured extends PhoneAuthState {
  final String message;
  PhoneAuthErrorOccured({this.message});
}

class PhoneNumberSubmited extends PhoneAuthState {}

class PhoneOtpCodeVerified extends PhoneAuthState {}
