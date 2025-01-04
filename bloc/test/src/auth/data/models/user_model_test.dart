

import 'dart:convert';

import 'package:bloc_reno/core/utils/typedefs.dart';
import 'package:bloc_reno/src/auth/data/models/user_model.dart';
import 'package:bloc_reno/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){

  const tLocalUserModel = LocalUserModel.empty();

  test('should be a subclass of [LocalUser] entity', () => expect(tLocalUserModel, isA<LocalUser>()));

  final tMap = jsonDecode(fixture('user.json')) as DataMap;

  group('fromMap', (){

    test('should return a valid [LocalUserModel] from the map', (){
        //act
      final result = LocalUserModel.fromMap(tMap);
    // expect(result, isA<LocalUserModel>());
      expect(result, equals(tLocalUserModel));
    });

    test('should throw an [Error] when the map is invalid', (){
      //act
      final map = DataMap.from(tMap)..remove('uid');
      
      const call = LocalUserModel.fromMap;
     
      expect(() => call(map), throwsA(isA<Error>()));
    });

  });
  
  group('toMap', (){
    test('shoudl return a valid [DataMap] from the model', (){
      final result = tLocalUserModel.toMap();
      expect(result, equals(tMap));
    });
  });
  
  group('copyWith', (){
    test('should return a valid [LocalUserModel] with updated values', (){
      final result = tLocalUserModel.copyWith(
        uid: '2'
      );
      
      expect(result.uid, '2');
      
    });
  });

}