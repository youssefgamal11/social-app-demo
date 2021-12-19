import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/register_user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(InitialRegisterState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var userNameController = TextEditingController();

  void saveUserData(
      {@required String email,
      @required String name,
      @required String phone,
      @required String uId}) {
    RegisterUserModel model = RegisterUserModel(
        phone: phone,
        email: email,
        name: name,
        uId: uId,
        bio: 'Write your bio',
        cover:
            'https://image.freepik.com/free-photo/rear-view-programmer-working-all-night-long_1098-18697.jpg',
        isEmailVerifyed: false,
        photo:
            'https://image.freepik.com/free-photo/medium-shot-happy-man-smiling_23-2148221808.jpg');
    emit(UserCreateLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserCreateSuccessState());
    }).catchError((onError) {
      emit(UserCreateErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  void userRegister(
      {@required String email,
      @required String password,
      @required String name,
      @required String phone}) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      saveUserData(uId: value.user.uid, name: name, email: email, phone: phone);
      emit(SocialRegisterSuccessState());
    }).catchError((onError) {
      emit(
        SocialRegisterErrorState(onError),
      );
      print(onError);
    });
  }
}
