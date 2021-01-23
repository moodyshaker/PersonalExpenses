import 'package:google_sign_in/google_sign_in.dart';

class UserProfile {
  String id;
  String name;
  String email;
  String photo;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.photo,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json, String photoUrl) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photo: photoUrl,
    );
  }

  factory UserProfile.fromSocial(GoogleSignInAccount account) {
    return UserProfile(
      id: account.id,
      name: account.displayName,
      email: account.email,
      photo: account.photoUrl,
    );
  }

  @override
  String toString() =>
      'id -> $id - name -> $name - email -> $email - photo -> $photo';
}
