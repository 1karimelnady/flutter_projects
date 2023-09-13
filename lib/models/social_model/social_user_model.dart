class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? bio;
  String? cover;

  SocialUserModel(
      {this.name,
      this.email,
      this.phone,
      this.uId,
      this.isEmailVerified,
      this.image,
      this.cover,
      this.bio});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    cover = json['cover'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'uId': uId,
      'cover': cover,
      'bio': bio,
    };
  }
}
