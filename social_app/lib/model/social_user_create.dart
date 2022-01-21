class SocialUserCreate {
  String name;
  String email;
  String phone;
  String uid;
  String bio;
  String image;
  String cover;
  bool isEmailVerified;

  SocialUserCreate(
      {this.name,
      this.email,
      this.phone,
      this.uid,
      this.isEmailVerified,
      this.image,
      this.cover,
      this.bio});

  SocialUserCreate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'cover': cover,
      'bio' : bio,
    };
  }
}
