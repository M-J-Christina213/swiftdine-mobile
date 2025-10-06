class UserProfile {
  final int id;
  final String name;
  final String email;
  final String? profilePhoto;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.profilePhoto,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePhoto: json['profile_photo_path'],
    );
  }
}
