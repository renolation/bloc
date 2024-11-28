import 'dart:convert';

import 'package:bloc/core/errors/exceptions.dart';
import 'package:bloc/core/utils/constants.dart';
import 'package:bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
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
}
