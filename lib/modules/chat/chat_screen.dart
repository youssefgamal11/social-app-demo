import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/register_user_model.dart';
import 'package:social_app/modules/chat/chat_details.dart';
import 'package:social_app/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              body: ConditionalBuilder(
                condition: cubit.users.length > 0,
                builder: (context) => ListView.separated(
                    itemBuilder: (context, index) =>
                        buildChatItem(context, cubit.users[index]),
                    separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                    itemCount: cubit.users.length),
                fallback: (context) => Center(child: SingleChildScrollView()),
              ));
        },
        listener: (context, state) {});
  }

  Widget buildChatItem(context, RegisterUserModel model) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ChatDetails(
              myModel: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage('${model.photo}'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Jannah', fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
