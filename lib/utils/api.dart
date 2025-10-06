class Api {
  static String token = "";
  static String baseUrl = "http://10.0.2.2:8000/api";

  static Map<String, String> headers() => {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
}
