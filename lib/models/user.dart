class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String code;
  final String? pushToken;
  final bool isVerified;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.code,
    required this.pushToken,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      firstname: data['firstname'],
      lastname: data['lastname'],
      email: data['email'],
      phone: data['phone'],
      code: data['code'],
      pushToken: data['pushtoken'],
      isVerified: data['is_verified'] == 1,
    );
  }
}

// {
//   id: 51,
//   firstname: Agboola,
//   lastname: Odunayo,
//   password: $2b$10$Ao.AC91A9jTMREiU/iiTEuS68tprRfobb/1pnly4rpOwmrZh7X7y6,
//   email: agboolaodunayo2016@gmail.com,
//   phone: ,
//   code: 645781,
//   pushtoken: null,
//   is_verified: 1,
// }
