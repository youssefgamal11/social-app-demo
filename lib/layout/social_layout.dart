import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Notification),
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Search),
                  color: Colors.black,
                ),
              ],
              title: Text(
                cubit.appBarTitle[cubit.currentIndex],
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.model != null,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeCurrentIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Home),
                      title: Text(
                        'home',
                        style: TextStyle(fontFamily: 'Jannah'),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Chat),
                      title: Text(
                        'chat',
                        style: TextStyle(fontFamily: 'Jannah'),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Plus),
                      title: Text(
                        'add post',
                        style: TextStyle(fontFamily: 'Jannah'),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Location),
                      title: Text(
                        'users',
                        style: TextStyle(fontFamily: 'Jannah'),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Setting),
                      title: Text(
                        'settings',
                        style: TextStyle(fontFamily: 'Jannah'),
                      )),
                ]),
          );
        },
        listener: (context, state) {
          if(state is SocialNewPostState){
            navigateTo(context, NewPostScreen());
          }
        });
  }

  Widget verifyWidget() {
    return Container(
      color: Colors.amber.shade300,
      child: Row(
        children: [
          if (!FirebaseAuth.instance.currentUser.emailVerified)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Icon(Icons.info_outline),
            ),
          Text('please verify your email'),
          Spacer(),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser
                    .sendEmailVerification()
                    .then((value) {
                  showToast(
                      state: ToastState.SUCCESS, message: 'check your email');
                });
              },
              child: Text('Send')),
        ],
      ),
    );
  }
}
