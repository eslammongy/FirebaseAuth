class UserModel {
  String name;
  String email;
  String phone;
  String uId;
  String image;


  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
    };
  }
}
