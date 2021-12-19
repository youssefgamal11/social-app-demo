import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 return BlocConsumer<SocialCubit , SocialStates>(builder: (context , state){
   var cubit = SocialCubit.get(context);
   return Scaffold(
     backgroundColor: Colors.white,
     body: ConditionalBuilder(
       condition: cubit.posts.length > 0 && cubit.model != null,
       builder:(context) => SingleChildScrollView(
         physics: BouncingScrollPhysics(),
         child: Column(
           children: [
             Card(
               clipBehavior: Clip.antiAliasWithSaveLayer,
               elevation: 5,
               margin: EdgeInsets.all(8),
               child: Image(
                 width: double.infinity,
                 height: 220,
                 fit: BoxFit.cover,
                 image: NetworkImage(
                     'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg'),
               ),
             ),
             SizedBox(height: 10),
             ListView.separated(
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemBuilder: (context , index)=> buildPostItem(context: context ,model: cubit.posts[index] , index: index), separatorBuilder:(context , index) => SizedBox(height: 2,), itemCount: cubit.posts.length)
           ],
         ),
       ),
       fallback: (context) => Center(child: SingleChildScrollView()),
     ),
   );

 }, listener: (context , state){});

  }
  Widget buildPostItem({ context , PostModel model ,index} ){
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        '${model.image}'),
                    radius: 25,
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Youssef Gamal',
                          style: TextStyle(
                              fontFamily: 'Jannah',
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 20,
                        )
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Jannah',
                          height: 1),
                    )
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 12),
              child: Container(height: 1, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 5 , top: 10),
              child: Text(
                '${model.text}' , style: TextStyle(fontFamily: 'Jannah' , fontSize: 16, height: 1.2),),
            ),
            SizedBox(height: 15),
            if(model.postImage != '')
              Card(
              child: Image(
                width: double.infinity,
                height: 300,
                image: NetworkImage('${model.postImage}'),
                fit: BoxFit.cover,
              ),
            ) ,
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                  }, icon: Icon(IconBroken.Heart, color: Colors.red,)) ,
                  Text('${SocialCubit.get(context).likes[index]}'),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(IconBroken.Message, color: Colors.yellow,)) ,
                  Text('0 comment'),
                ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 12),
              child: Container(height: 1, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(

                    backgroundImage:NetworkImage( '${SocialCubit.get(context).model.photo}'),
                    radius: 20,
                  ),
                ),
                Text(' write comment....'),
                Spacer(),
                IconButton(icon: Icon(IconBroken.Heart, color: Colors.red,),),
                Text('Like'),
              ],),
            )


          ],
        ));
  }
}
