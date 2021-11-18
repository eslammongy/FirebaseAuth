abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthErrorOccurred extends PhoneAuthState {
  final String message;

  PhoneAuthErrorOccurred({required this.message});
}

class PhoneNumberSubmitted extends PhoneAuthState {}

class PhoneOtpCodeVerified extends PhoneAuthState {}

class ChangeProfileImageSuccess extends PhoneAuthState {}

class ChangeProfileImageError extends PhoneAuthState {
  final String errorMessage;

  ChangeProfileImageError({required this.errorMessage});
}

class UserSignUpLoading extends PhoneAuthState {}

class UserSignUpSuccess extends PhoneAuthState {}

class UserSignUpError extends PhoneAuthState {
  final String errorMessage;

  UserSignUpError({required this.errorMessage});
}

class CreateNewUserLoading extends PhoneAuthState {}

class CreateNewUserSuccess extends PhoneAuthState {}

class CreateNewUserError extends PhoneAuthState {
  final String errorMessage;

  CreateNewUserError({required this.errorMessage});
}


class UploadUserProfileImageSuccess extends PhoneAuthState {}

class UploadUserProfileImageError extends PhoneAuthState {
  final String errorMessage;

  UploadUserProfileImageError({required this.errorMessage});
}

class GetUserInfoLoadingStatus extends PhoneAuthState {}

class GetUserInfoSuccessStatus extends PhoneAuthState {}

class GetUserInfoErrorStatus extends PhoneAuthState {
  final String errorMessage;

  GetUserInfoErrorStatus({required this.errorMessage});
}

class UpdateUserInfo extends PhoneAuthState{}

class UpdateCurrentUserInfoLoading extends PhoneAuthState{}
class UpdateCurrentUserInfoSuccess extends PhoneAuthState{}
class UpdateCurrentUserInfoError extends PhoneAuthState{
  final String errorMessage;

  UpdateCurrentUserInfoError({required this.errorMessage});
}