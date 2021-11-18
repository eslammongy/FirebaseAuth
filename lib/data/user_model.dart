class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  String? password;


  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.image,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    password = json['password'];
  }

  Map<String, dynamic?> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'password': password,
    };
  }
}
