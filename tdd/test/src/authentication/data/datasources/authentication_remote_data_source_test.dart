import 'dart:convert';

import 'package:bloc_test/core/errors/exceptions.dart';
import 'package:bloc_test/core/utils/constants.dart';
import 'package:bloc_test/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bloc_test/src/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;

  late AuthenticationRemoteDataSource remoteDataSource;


  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRepoDataSrcImpl(client: client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successful when status code is 200 or 201', () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;

      expect(
           methodCall(
              createdAt: '2021-09-01', name: 'name', avatar: 'avatar'),
          completes);

      verify(() => client.post(Uri.parse('$kBaseUrl$kCreateUserEndPoint'),
          body: jsonEncode({
            'createdAt': '2021-09-01',
            'name': 'name',
            'avatar': 'avatar'
          }))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw api exception', () async {

      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
              (_) async => http.Response('Invalid', 400));

      final methodCall = remoteDataSource.createUser;

      expect(() async => methodCall(
          createdAt: '2021-09-01', name: 'name', avatar: 'avatar'
      ), throwsA(const APIException(message: 'Invalid', statusCode: 400)));

      verify(() => client.post(Uri.parse('$kBaseUrl$kCreateUserEndPoint'),
          body: jsonEncode({
            'createdAt': '2021-09-01',
            'name': 'name',
            'avatar': 'avatar'
          }))).called(1);
      verifyNoMoreInteractions(client);

    });

  });

  group('getUsers', () {

    const tUser = [UserModel.empty()];

    test('should return [List<User>] when the status code is 200', () async{
      when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode(tUser.first.toMap()), 200));

      final result = await remoteDataSource.getUsers();

      expect(result.first, equals(tUser));

      verify(() => client.get(Uri.parse('$kBaseUrl$kGetUserEndPoint', ))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200', () async{
      when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode('Server down'), 500));

      final methodCall =  remoteDataSource.getUsers;

      expect(() => methodCall(), throwsA(const APIException(message: 'Server down', statusCode: 500)));

      verify(() => client.get(Uri.parse('$kBaseUrl$kGetUserEndPoint',))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
