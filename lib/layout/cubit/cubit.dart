import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/register_user_model.dart';
import 'package:social_app/modules/chat/chat_screen.dart';
import 'package:social_app/modules/home/home_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  RegisterUserModel model;
  void getUserData() {
    emit(SocialGetDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value);
      emit(SocialGetDataSuccessState());
      model = RegisterUserModel.fromJson(value.data());
      print(model.uId);
    }).catchError((onError) {
      emit(SocialGetDataFailedState());
      print(onError.toString());
    });
  }

  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> appBarTitle = [
    'Home',
    'Chat',
    '',
    'user',
    'Settings',
  ];
  int currentIndex = 0;
  void changeCurrentIndex(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }

  File profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      print(pickedImage);
      emit(SocialPickImageSuccessState());
    } else {
      emit(SocialPickImageFailedState());
      return 'you should pick image';
    }
  }

  File coverImage;
  Future<void> pickCoverImage() async {
    final pickedCover = await picker.pickImage(source: ImageSource.gallery);
    if (pickedCover != null) {
      coverImage = File(pickedCover.path);
      emit(SocialPickCoverSuccessState());
    } else {
      emit(SocialPickImageFailedState());
      return "you should pick image";
    }
  }

  void uploadProfileImage({
    @required String bio,
    @required String phone,
    @required String name,
  }) {
    emit(SocailUserUpdateLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadImageSuccessState());
        updateUser(bio: bio, phone: phone, name: name, image: value);
      }).catchError((onError) {});
    }).catchError((onError) {
      emit(SocialUploadImageFailedState());
    });
  }

  void uploadProfileCover({
    @required String bio,
    @required String phone,
    @required String name,
  }) {
    emit(SocailUserUpdateLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverSuccessState());
        updateUser(bio: bio, phone: phone, name: name, cover: value);
      }).catchError((onError) {});
    }).catchError((onError) {
      emit(SocialUploadCoverFailedState());
    });
  }

  // void updateUserImages({
  //   @required String bio,
  //   @required String phone,
  //   @required String name,
  // }) {
  //   emit(SocailUserUpdateLoading());
  //   if(profileImage != null){
  //     uploadProfileImage();
  //   }
  //   else if( coverImage != null){
  //     uploadProfileCover();
  //   }else{
  //
  //   }
  // }

  void updateUser({
    @required String bio,
    @required String phone,
    @required String name,
    String image,
    String cover,
  }) {
    RegisterUserModel userModel = RegisterUserModel(
      photo: image ?? model.photo,
      cover: cover ?? model.cover,
      isEmailVerifyed: false,
      bio: bio,
      phone: phone,
      email: model.email,
      name: name,
      uId: model.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(SocailUserUpdateError());
    });
  }

  File postImage;
  Future<void> pickPostImage() async {
    final pickedCover = await picker.pickImage(source: ImageSource.gallery);
    if (pickedCover != null) {
      postImage = File(pickedCover.path);
      emit(SocialPickPostImageSuccessState());
    } else {
      emit(SocialPickPostImageFailedState());
      return "you should pick image";
    }
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((onError) {});
    }).catchError((onError) {
      emit(SocialUploadImageFailedState());
    });
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel userModel = PostModel(
      name: model.name,
      uId: model.uId,
      text: text,
      dateTime: dateTime,
      image: model.photo,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(userModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removeImage() {
    postImage = null;
    emit(SocialRemovePostImage());
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postId.add(element.id);
        }).catchError((onError) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((onError) {
      emit(SocialGetPostsErrorState(
        onError.toString(),
      ));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((onError) {
      emit(SocialLikePostErrorState());
    });
  }

  List<RegisterUserModel> users = [];
  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != model.uId)
            users.add(RegisterUserModel.fromJson(element.data()));
        });
        emit(SocialGetUsersSuccessState());
      }).catchError((onError) {
        emit(SocialGetUsersErrorState(onError));
      });
  }

  void sendMessage(
      {@required String text,
      @required String reciverId,
      @required String dateTime}) {
    MessageModel messageModel = MessageModel(
        dateTime: dateTime,
        text: text,
        reciverId: reciverId,
        senderId: model.uId);

    //set my chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError) {
      emit(SocialSendMessageFailedState());
    });

    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageFailedState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({@required String reciverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        print(
            "!____________________/// this is my message___________$messages  ________________");
      });
    });
    emit(SocialGetMessageSuccessState());
  }
}
