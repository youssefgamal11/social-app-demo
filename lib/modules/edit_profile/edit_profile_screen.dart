import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        nameController.text = cubit.model.name;
        bioController.text = cubit.model.bio;
        phoneController.text = cubit.model.phone;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(
                  fontFamily: 'Jannah', fontSize: 20, color: Colors.black),
            ),
            leading: Icon(IconBroken.Arrow___Left_2),
            actions: [
              TextButton(
                  onPressed: () {
                    cubit.updateUser(
                        bio: bioController.text,
                        phone: phoneController.text,
                        name: nameController.text);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // if (state is SocailUserUpdateLoading)
                Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Card(
                              child: Image(
                                width: double.infinity,
                                height: 140,
                                image: cubit.coverImage == null
                                    ? NetworkImage('${cubit.model.cover}')
                                    : FileImage(cubit.coverImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      cubit.pickCoverImage();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                    ))),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage: cubit.profileImage == null
                                  ? NetworkImage('${cubit.model.photo}')
                                  : FileImage(cubit.profileImage),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                                radius: 17,
                                child: IconButton(
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 17,
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (cubit.profileImage != null || cubit.coverImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8),
                    child: Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defalutButton(
                                    name: 'upload Profile',
                                    tap: () {
                                      cubit.uploadProfileImage(
                                          bio: bioController.text,
                                          phone: phoneController.text,
                                          name: nameController.text);
                                    }),
                                if (state is SocailUserUpdateLoading)
                                  SizedBox(
                                    height: 5,
                                  ),
                                if(state is SocailUserUpdateLoading)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defalutButton(
                                    name: 'upload Cover',
                                    tap: () {
                                      cubit.uploadProfileCover(
                                          bio: bioController.text,
                                          phone: phoneController.text,
                                          name: nameController.text);
                                    }),
                                if (state is SocailUserUpdateLoading)
                                  SizedBox(
                                    height: 5,
                                  ),
                                if (state is SocailUserUpdateLoading)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultTextFormField(
                      controller: nameController,
                      icon: IconBroken.User,
                      label: 'name'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultTextFormField(
                      controller: bioController,
                      icon: IconBroken.Info_Circle,
                      label: 'bio'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultTextFormField(
                      controller: phoneController,
                      icon: IconBroken.Call,
                      label: 'phone'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
