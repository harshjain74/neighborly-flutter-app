import 'dart:convert';

import 'package:neighborly_flutter_app/core/constants/constants.dart';
import 'package:neighborly_flutter_app/core/error/exception.dart';
import 'package:neighborly_flutter_app/core/models/post_model.dart';
import 'package:neighborly_flutter_app/core/utils/shared_preference.dart';
import 'package:neighborly_flutter_app/features/profile/data/data_sources/profile_remote_data_source/profile_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:neighborly_flutter_app/features/profile/data/models/auth_response_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});
  @override
  Future<String> changePassword(
      {String? currentPassword,
      required String newPassword,
      required String email,
      required bool flag}) async {
    Map<String, dynamic> queryParameters = {
      'newPassword': newPassword,
      'email': email,
      'flag': flag,
    };
    if (currentPassword != null) {
      queryParameters['currentPassword'] = currentPassword;
    }
    String url = '$kBaseUrl/user/change-password';

    final response = await client.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(queryParameters),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['msg'];
    } else {
      throw ServerException(message: jsonDecode(response.body)['error']);
    }
  }

  @override
  Future<void> updateLocation({required List<num> location}) async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    // print('Cookies: $cookieHeader');
    String url = '$kBaseUrl/user/update-user-location';
    final response = await client.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
      body: jsonEncode({'homeLocation': location}),
    );

    if (response.statusCode != 200) {
      throw ServerException(message: jsonDecode(response.body)['error']);
    }
  }

  @override
  Future<void> getGenderAndDOB({String? gender, String? dob}) async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    // print('Cookies: $cookieHeader');
    String url = '$kBaseUrl/user/update-user-info';
    final response = await client.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
      body: jsonEncode({'gender': gender, 'dob': dob}),
    );

    if (response.statusCode != 200) {
      throw ServerException(message: jsonDecode(response.body)['error']);
    }
  }

  @override
  Future<AuthResponseModel> getProfile() async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    // print('Cookies: $cookieHeader');
    String url = '$kBaseUrl/profile/user-info';
    final response = await client.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(message: jsonDecode(response.body)['error']);
    }
  }

  @override
  Future<void> logout() async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    // print('Cookies: $cookieHeader');
    String url = '$kBaseUrl/authentication/logout';
    final response = await client.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException(message: jsonDecode(response.body)['msg']);
    }
  }

  @override
  Future<List<PostModel>> getMyPosts() async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    String? userId = ShardPrefHelper.getUserID();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    // print('Cookies: $cookieHeader');
    String url = '$kBaseUrl/profile/user-content';
    Map<String, dynamic> queryParameters = {'userId': '$userId'};

    final response = await client.get(
      Uri.parse(url).replace(queryParameters: queryParameters),
      headers: <String, String>{
        'Cookie': cookieHeader,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((data) => PostModel.fromJson(data)).toList();
    } else {
      final message = jsonDecode(response.body)['msg'] ?? 'Unknown error';
      throw ServerException(message: message);
    }
  }

  @override
  Future<void> sendFeedback({required String feedback}) async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    // print('Cookies: $cookieHeader');
    String url = '$kBaseUrl/profile/send-feedback';
    final response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
      body: jsonEncode({'feedbackText': feedback}),
    );

    if (response.statusCode != 200) {
      throw ServerException(message: jsonDecode(response.body)['error']);
    }
  }

  @override
  Future<void> deleteAccount() async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    String url = '$kBaseUrl/profile/delete-account';
    final response = await client.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException(message: jsonDecode(response.body)['error']);
    }
  }
}
