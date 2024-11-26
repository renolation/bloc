
import 'dart:convert';
import 'dart:io';

import 'package:bloc/core/utils/typedef.dart';
import 'package:bloc/src/authentication/data/models/user_model.dart';
import 'package:bloc/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {

  const tModel = UserModel.empty();

  test('should be sub class', (){
    expect(tModel, isA<User>());
  });

  final tJson = fixtures('user.json');
  final tMap = jsonDecode(tJson) as DataMap;
  group('fromMap', (){
    test('should return a [UserModel]', (){

      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });
  group('fromJson', (){
    test('should return a [UserModel]', (){
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', (){
    test('should return a [Map]', (){
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });
  group('toJson', (){
    test('should return a [Json]', (){
      final result = tModel.toJson();
      expect(result, equals(tJson));
    });
  });
}