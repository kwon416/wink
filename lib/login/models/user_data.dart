class UserData {
  String userName;
  String email;
  String uid;
  String password;
  String phoneNo;
  bool isVerified;


  UserData({required this.userName, required this.email, required this.uid, required this.password, required this.phoneNo, this.isVerified = false});

  factory UserData.fromJson(Map<Object?, dynamic> json) {
    return UserData(
      userName : json["userName"] as String,
      email : json["email"] as String,
      uid : json["uid"] as String,
      password : json["password"] as String,
      phoneNo : json["phoneNo"] as String,
      isVerified : json["isVerified"] as bool,
    );
    }


  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'uid': uid,
      'password': password,
      'phoneNo': phoneNo,
      'isVerified': isVerified,
    };
  }
}