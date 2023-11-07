class ProfileModel {
  String username;
  String email;
  final String password;
  final bool verified;
  final String role;
  String firstname;
  String lastname;
  final String dob;
  String gender;
  final num weight;
  final num height;
  final List allergy;
  final List dislikes;
  String image;
  String phonenumber;
  String address;
  final num balance;
  bool isSubscribed;
  int subscriptionStartDate;
  int subscriptionEndDate;
  String subscriptionId;
  List subusers;

  ProfileModel({
    required this.username,
    required this.email,
    required this.password,
    required this.verified,
    required this.role,
    required this.firstname,
    required this.lastname,
    required this.dob,
    required this.gender,
    required this.weight,
    required this.height,
    required this.allergy,
    required this.dislikes,
    required this.image,
    required this.phonenumber,
    required this.address,
    required this.balance,
    required this.isSubscribed,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.subscriptionId,
    required this.subusers,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json["username"],
      email: json["email"],
      password: json["password"],
      verified: json["verified"],
      role: json["role"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      dob: json["dob"] ?? "${DateTime.now()}",
      gender: json["gender"],
      weight: json["weight"],
      height: json["height"],
      allergy: json["allergy"],
      dislikes: json["dislikes"],
      image: json["image"],
      phonenumber: json["phonenumber"],
      address: json["address"],
      balance: json['balance'],
      isSubscribed: json['isSubscribed'],
      subscriptionStartDate: json['subscriptionStartDate'],
      subscriptionEndDate: json['subscriptionEndDate'],
      subscriptionId: json['subscriptionId'],
      subusers: json['subusers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "verified": verified,
      "role": role,
      "firstname": firstname,
      "lastname": lastname,
      "dob": dob,
      "gender": gender,
      "weight": weight,
      "height": height,
      "allergy": allergy,
      "dislikes": dislikes,
      "image": image,
      "phonenumber": phonenumber,
      "address": address,
      "balance": balance,
      'isSubscribed': isSubscribed,
      'subscriptionStartDate': subscriptionStartDate,
      'subscriptionEndDate': subscriptionEndDate,
      'subscriptionId': subscriptionId,
      'subusers': subusers,
    };
  }
}
