class RegisterUserModel {
  String name;
  String phone;
  String email;
  String uId;
  String cover;
  String photo;
  String bio;
  bool isEmailVerifyed;

  RegisterUserModel(
      {this.uId, this.email, this.name, this.phone, this.isEmailVerifyed , this.photo , this.cover , this.bio});
  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    name = json['name'];
    cover = json['cover'];
    photo = json['photo'];
    bio = json['bio'];
    isEmailVerifyed = json['isEmailVerifed'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'cover': cover,
      'photo': photo,
      'uid':uId,
      'bio' :bio,
      'isEmailVerifyed': isEmailVerifyed,
    };
  }
}
