class UserModel {
  late String name;

  late String email;

  late String phone;

  late String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    print("Map function") ;
    return {'name': name, 'email': email, 'phone': phone, 'uid': uid};
  }
}
