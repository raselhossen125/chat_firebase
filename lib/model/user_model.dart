const userUid = 'uid';
const userName = 'name';
const userEmail = 'email';
const userPhone = 'phone';
const userImage = 'image';
const userAvailable = 'available';
const userDeviceToken = 'deviceToken';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? image;
  bool available;
  String? deviceToken;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.available = true,
    this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userUid: uid,
      userName: name,
      userEmail: email,
      userPhone: phone,
      userImage: image,
      userAvailable: available,
      userDeviceToken: deviceToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uid: map[userUid],
        name: map[userName],
        email: map[userEmail],
        phone: map[userPhone],
        image: map[userImage],
        available: map[userAvailable],
        deviceToken: map[userDeviceToken],
      );
}
