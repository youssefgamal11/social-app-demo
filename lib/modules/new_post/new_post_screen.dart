import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key key}) : super(key: key);

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(builder: (context , state){
      var cubit = SocialCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: defaultAppBar(title: 'Create Post', buttonName: 'Post' , function: (){
          var now = DateTime.now();
          if(cubit.postImage == null){
            cubit.createPost(dateTime: now.toString(), text: textController.text);
          }else{
            cubit.uploadPostImage(dateTime: now.toString(), text: textController.text);
          }
        } ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 10,),
              Row(children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://scontent.faly2-1.fna.fbcdn.net/v/t1.6435-1/p160x160/230253875_4418474784869562_6611885410607195820_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=7206a8&_nc_eui2=AeEtt4ehlNueKHc3tr-6G_g9ZDIUtuSq8w1kMhS25KrzDQ_diB5hPy9RWG94w4tvRBDPm-OTWeBWOwvln3XVYaih&_nc_ohc=Ejlx-oRFQSEAX-EKuZi&tn=DfUMZg3BWXcVknEH&_nc_ht=scontent.faly2-1.fna&oh=7a9e8e1a1c256e0322d6675a6441962b&oe=61A76692'),
                ),
                SizedBox(width: 10,),
                Text('youssef gamal' , style: TextStyle(color: Colors.black , fontFamily: 'Jannah' , fontSize: 17),)
              ],),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none
                  ),
                ),
              ),
              if(cubit.postImage != null)
              Container(
                height: 200,
                child: Stack(
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
                              image: FileImage(cubit.postImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    cubit.removeImage();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                  ))),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){
                    cubit.pickPostImage();
                  }, child: Row(
                    children: [
                      Icon(IconBroken.Image),
                      Text('add photo' ,style: TextStyle(color: Colors.blue , fontFamily: 'Jannah' , fontSize: 17),)
                    ],
                  )),
                  TextButton(onPressed: (){}, child: Text('#tag',style: TextStyle(fontSize: 17 , fontFamily: 'Jannah'),))
                ],
              ),
            ],
          ),
        ),
      );
    }, listener: (context , state){});
  }
}
