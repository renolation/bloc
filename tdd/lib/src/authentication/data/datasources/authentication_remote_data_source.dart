import 'dart:convert';

import 'package:bloc/core/errors/exceptions.dart';
import 'package:bloc/core/utils/constants.dart';
import 'package:bloc/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/typedef.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndPoint = '/users';
const kGetUserEndPoint = '/users';

class AuthRepoDataSrcImpl implements AuthenticationRemoteDataSource {
  final http.Client client;

  const AuthRepoDataSrcImpl({required this.client});

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await client.post(
          Uri.parse('$kBaseUrl$kCreateUserEndPoint'),
          body: jsonEncode(
              {'createdAt': createdAt, 'name': name, 'avatar': avatar}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client.get(Uri.parse('$kBaseUrl$kGetUserEndPoint'));
      print(response.body);
      if(response.statusCode != 200){
        throw APIException(message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((e) => UserModel.fromMap(e))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
