import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_profile.dart';

Future<UserProfile?> fetchUserProfile(String token) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/user-profile'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return UserProfile.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}
