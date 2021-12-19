
abstract class SocialLoginStates {}
class InitialLoginState extends SocialLoginStates {}
class SocialLoginSuccessState extends SocialLoginStates{
  String uid  ;
  SocialLoginSuccessState({this.uid});
}
class SocialLoginErrorState extends SocialLoginStates{
  final String  error ;
  SocialLoginErrorState(this.error);

}
class SocialLoginLoadingState extends SocialLoginStates {}