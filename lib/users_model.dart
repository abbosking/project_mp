class User {
  final String firstName;
  final String lastName;
  final String email;
  final String mediumPictureUrl;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mediumPictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
      mediumPictureUrl: json['picture']['medium'], // Extract medium-sized picture URL
    );
  }
}
