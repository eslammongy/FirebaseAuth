class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  String? password;
  String? bio;


  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.image,
    this.password,
    this.bio
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    password = json['password'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'password': password,
      'bio': bio,
    };
  }
}
