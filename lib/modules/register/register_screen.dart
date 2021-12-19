import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context , state){
          if(state is UserCreateSuccessState){
            navigateAndFinish(context, SocialLayoutScreen());
          }
        },
        builder: (context , state){
          var cubit = SocialRegisterCubit.get(context);
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black, fontSize: 25),
                        ),
                        SizedBox(height: 10),
                        Text('Register now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey, fontSize: 20)),
                        SizedBox(
                          height: 40,
                        ),
                        defaultTextFormField(
                            label: 'user name',
                            controller: cubit.userNameController,
                            icon: Icons.person,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'email must not be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            label: 'email',
                            controller: cubit.emailController,
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
                            controller: cubit.passwordController,
                            icon: Icons.lock_outline,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return ' password must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            label: 'phone',
                            controller: cubit.phoneController,
                            icon: Icons.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return ' phone must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defalutButton(
                              name: 'Register',
                              tap: () {
                                if (formKey.currentState.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text,
                                    name: cubit.userNameController.text,
                                    phone: cubit.phoneController.text,
                                  );
                                }

                              }),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
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
