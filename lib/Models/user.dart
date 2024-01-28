class userModel {
  String? uid;
  String? name;
  String? email;
  String? pwd;
  String? phone;
  String? role;
  bool? isVerified;

  userModel({
    this.uid,
    this.name,
    this.email,
    this.pwd,
    this.phone,
    this.role,
    this.isVerified = false,
  });

  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      pwd: json['pwd'],
      phone: json['phone'],
      role: json['role'],
      isVerified: json['isVerified']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'pwd': pwd,
      'phone': phone,
      'role': role,
      'isVerified': isVerified,
    };
  }
}