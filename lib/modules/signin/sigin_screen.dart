import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/modules/signin/cubit/cubit.dart';
import 'package:social_app/modules/signin/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(state: ToastState.ERROR, message: state.error);
          } else if(state is SocialLoginSuccessState){
            CacheHelper.saveData(key: 'uid', value: state.uid).then((value){ navigateAndFinish(context,SocialLayoutScreen());});
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black, fontSize: 25),
                        ),
                        SizedBox(height: 10),
                        Text('Login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey, fontSize: 20)),
                        SizedBox(
                          height: 40,
                        ),
                        defaultTextFormField(
                            label: 'email',
                            controller: emailController,
                            icon: Icons.email,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return ' email must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            label: 'password',
                            isPassword: true,
                            controller: passwordController,
                            icon: Icons.lock_outline,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return ' password must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defalutButton(
                              name: 'LOGIN',
                              tap: () {
                                if (formKey.currentState.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account ? ',
                              style: TextStyle(fontSize: 17),
                            ),
                            textButton(
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                                name: 'REGISTER')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
