class PostModel {
  String name;
  String uId;
  String image ;
  String dateTime ;
  String text ;
  String postImage ;

  PostModel(
      {this.uId, this.name , this.text , this.image , this.dateTime , this.postImage});
  PostModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    uId = json['uId'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid':uId,
      'image':image ,
      'dateTime' : dateTime ,
      'text' : text ,
      'postImage':postImage,

    };
  }
}
