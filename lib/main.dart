import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/network/local.dart';
import 'layout/cubit/cubit.dart';
import 'modules/signin/cubit/bloc_observer.dart';
import 'modules/signin/sigin_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingbackGroundHandler(RemoteMessage message) {
  print('background message');
  print(message.data.toString());
  showToast(state: ToastState.SUCCESS, message: 'background FCM');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(state: ToastState.SUCCESS, message: 'on message');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(state: ToastState.SUCCESS, message:'on app opend' );
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingbackGroundHandler);
  Widget widget;
  uId = CacheHelper.getData(key: 'uid');
  if (uId != null) {
    widget = SocialLayoutScreen();
  } else {
    widget = SigninScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: ThemeData(
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontFamily: 'Jannah'),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
          ),
          fontFamily: 'Tajawal',
          textTheme: TextTheme(),
        ),
      ),
    );
  }
}
