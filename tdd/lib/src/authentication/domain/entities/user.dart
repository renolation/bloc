
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String createAt;
  final String avatar;

  const User({
    required this.id,
    required this.name,
    required this.createAt,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id];
}