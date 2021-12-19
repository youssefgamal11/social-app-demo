import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/modules/signin/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(InitialLoginState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  void userLogin({@required String email, @required String password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(SocialLoginSuccessState(uid:value.user.uid));
      print(value.user);
    }).catchError((onError){
      emit(SocialLoginErrorState(onError));
      print(onError.toString());
    });
  }
}
