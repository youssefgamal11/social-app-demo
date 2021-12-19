import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

Widget defaultAppBar({@required String title , @required String buttonName ,   Function function}){
  return AppBar(
    title: Text(
      '$title',
      style: TextStyle(
          fontFamily: 'Jannah', fontSize: 20, color: Colors.black),
    ),
    leading: Icon(IconBroken.Arrow___Left_2),
    actions: [
      TextButton(
          onPressed: function ,
          child: Text(
            '$buttonName',
            style: TextStyle(fontSize: 17 , color: Colors.blue),
          )),
    ],
  );
}
void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
          (Route<dynamic> route) => false);
}
void navigateTo(context , widget){
  Navigator.push(context, MaterialPageRoute(builder: (context) =>widget));
}

Widget defalutFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData subffix,
  Function suffixPressed,
  Function tap,
  bool isClickable = true,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    enabled: isClickable,
    onFieldSubmitted: (s) {
      onSubmit(s);
    },
    onChanged: (s) {
      onChange(s);
    },
    validator: (s) {
      validate(s);
    },
    onTap: () {
      tap();
    },
    decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: subffix != null
            ? IconButton(
            icon: Icon(subffix),
            onPressed: () {
              suffixPressed();
            })
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        )),
  );
}

Widget defalutButton({@required Function tap, @required String name}) {
  return InkWell(
    onTap: () {
      tap();
    },
    child: Container(
      width: double.infinity,
      height: 50,
      color: Colors.blue,
      child: Center(
          child: Text(
            '$name',
            style: TextStyle(color: Colors.white, fontSize: 17),
          )),
    ),
  );
}

Widget textButton({@required Function function, @required String name}) {
  return TextButton(
    child: Text('$name'),
    onPressed: () {
      function();
    },
  );
}

Widget defaultTextFormField({
  @required Function validate,
  @required TextEditingController controller,
  @required IconData icon,
  bool isPassword = false,
  Function onSubmit,
  @required String label,
}) {
  return TextFormField(
    validator: (s) {
      validate(s);
    },
    controller: controller,
    obscureText: isPassword,
    onFieldSubmitted: (s) {
      onSubmit(s);
    },
    decoration: InputDecoration(
      labelText: '$label',
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(),
    ),
  );
}

void showToast({@required ToastState state, @required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARRING }
Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;

    case ToastState.WARRING:
      color = Colors.orange;
      break;
  }
  return color;
}
