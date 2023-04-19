

class UserData {
  String userName;
  String gender;
  String phoneNo;
  String uid;
  int coin;
  String fcmToken;
  Map<Object?, Object?> wink;


  UserData({required this.userName, required this.gender, required this.phoneNo, required this.uid, required this.coin, required this.fcmToken, required this.wink });

  factory UserData.fromJson(Map<Object?, Object?> json) {
    return UserData(
      userName : json["userName"] as String,
      gender : json["gender"] as String,
      phoneNo : json["phoneNo"] as String,
      uid : json["uid"] as String,
      coin : json["coin"] as int,
      fcmToken : json["fcmToken"] as String,
      wink : json["wink"] as Map<Object?, Object?>,
    );
    }


  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'gender': gender,
      'phoneNo': phoneNo,
      'uid': uid,
      'coin': coin,
      'fcmToken': fcmToken,
      'wink': wink,
    };
  }
}