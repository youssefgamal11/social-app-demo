import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/register_user_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  RegisterUserModel myModel;
  ChatDetails({this.myModel});
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessages(reciverId: myModel.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${myModel.photo}'),
                      radius: 22,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${myModel.name}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Jannah'),
                    )
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages != null,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).model.uId == message.senderId)
                                return messageSent(message);
                              return messageRecived(message);
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15),
                            itemCount: SocialCubit.get(context).messages.length),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    hintText: 'write your message ...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        text: messageController.text,
                                        reciverId: myModel.uId,
                                        dateTime: DateTime.now().toString());
                                  },
                                  icon: Icon(
                                    IconBroken.Send,
                                    color: Colors.blue,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
          listener: (context, state) {});
    });
  }

  Widget messageRecived(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '${messageModel.text}',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Jannah', fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
  Widget messageSent(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '${messageModel.text}',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Jannah', fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
