part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthErrorOccurred extends PhoneAuthState {
  final String message;

  PhoneAuthErrorOccurred({this.message});
}

class PhoneNumberSubmitted extends PhoneAuthState {}

class PhoneOtpCodeVerified extends PhoneAuthState {}

class ChangeProfileImageSuccess extends PhoneAuthState {}

class ChangeProfileImageError extends PhoneAuthState {
  final String errorMessage;

  ChangeProfileImageError({this.errorMessage});
}

class CreateNewUserLoading extends PhoneAuthState {}

class CreateNewUserSuccess extends PhoneAuthState {}

class CreateNewUserError extends PhoneAuthState {
  final String errorMessage;

  CreateNewUserError({this.errorMessage});
}


class UploadUserProfileImageSuccess extends PhoneAuthState {}

class UploadUserProfileImageError extends PhoneAuthState {
  final String errorMessage;

  UploadUserProfileImageError({this.errorMessage});
}

class GetUserInfoLoadingStatus extends PhoneAuthState {}

class GetUserInfoSuccessStatus extends PhoneAuthState {}

class GetUserInfoErrorStatus extends PhoneAuthState {
final String errorMessage;

GetUserInfoErrorStatus({this.errorMessage});
}
