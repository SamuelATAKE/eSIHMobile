class User {
  User({required this.userName, required this.password});

  String userName;
  String password;
  String imagePath = "";
  String about = "";
  String email = "";
  String nom = "";
  bool isDarkMode = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "userName": userName,
      "password": password,
      "imagePath": imagePath,
      "about": about,
      "email": email,
      "nom": nom,
      "isDarkMode": isDarkMode
    };
  }
}
