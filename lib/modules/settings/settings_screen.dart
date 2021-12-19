import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Card(
                              child: Image(
                                width: double.infinity,
                                height: 140,
                                image: NetworkImage('${cubit.model.cover}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  NetworkImage('${cubit.model.photo}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${cubit.model.name}',
                      style: TextStyle(fontFamily: 'Jannah', fontSize: 22),
                    ),
                    Text(
                      '${cubit.model.bio}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 15),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '265',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Photos',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '4K',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '64',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followings',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {}, child: Text('Add Photos'))),
                        SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              navigateTo(context, EditProfileScreen());
                            }, child: Icon(IconBroken.Edit))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
