abstract class SocialRegisterStates {}

class InitialRegisterState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class UserCreateSuccessState extends SocialRegisterStates {}

class UserCreateErrorState extends SocialRegisterStates {
  final String error;
  UserCreateErrorState(this.error);
}

class UserCreateLoadingState extends SocialRegisterStates {}
