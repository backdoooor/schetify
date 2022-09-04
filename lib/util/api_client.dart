import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIClient{
  final API_URL = "https://api.national-holidays.jp";

  Future<Options> getAuthHeader() async{
    final token = await FirebaseAuth.instance.currentUser?.getIdToken(true);
    if (FirebaseAuth.instance.currentUser == null || token == null){
      throw Exception("Failed to login");
    }
    return Options(headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
  }

  Future<Response<dynamic>> get(String endpoint, bool withAuth) async{
    final response = await Dio().get('$API_URL/$endpoint', options: withAuth ? await getAuthHeader(): Options(headers: {
      "Content-Type": "application/json",
    }));
    return response;
  }

  Future<Response<dynamic>> post(String endpoint, Map<String, dynamic> jsonData, bool withAuth) async{
    final data = FormData.fromMap(jsonData);
    final response = await Dio().post('$API_URL/$endpoint', data: data, options: withAuth ? await getAuthHeader(): Options(headers: {
      "Content-Type": "application/json",
    }));
    return response;
  }

  Future<Response<dynamic>> put(String endpoint, Map<String, dynamic> jsonData, bool withAuth) async{
    final data = FormData.fromMap(jsonData);
    final response = await Dio().put('$API_URL/$endpoint', data: data, options: withAuth ? await getAuthHeader(): Options(headers: {
      "Content-Type": "application/json",
    }));
    return response;
  }

  Future<Response<dynamic>> delete(String endpoint, bool withAuth) async{
    final response = await Dio().delete('$API_URL/$endpoint', options: withAuth ? await getAuthHeader(): Options(headers: {
      "Content-Type": "application/json",
    }));
    return response;
  }
}