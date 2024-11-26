import 'dart:convert';

import 'package:bloc/src/authentication/domain/entities/user.dart';

import '../../../../core/utils/typedef.dart';


class UserModel extends User {
  const UserModel({
    required super.createdAt,
    required super.id,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty()
   : this(
    id: 1,
    createdAt: '',
    name: '',
    avatar: '',
  );

  UserModel copyWith({
    int? id,
    String? name,
    String? createdAt,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: map['createdAt'] as String,
      avatar: map['avatar'] as String,
    );
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source) as DataMap);

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "name": name,
    "avatar": avatar,
    "id": id,
  };

}
