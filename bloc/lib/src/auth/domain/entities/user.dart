import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    this.profilePic,
    this.groupIds = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
    this.bio,
  });

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          profilePic: '',
          points: 0,
          fullName: '',
          groupIds: const [],
          enrolledCourseIds: const [],
          following: const [],
          followers: const [],
        );

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, bio: $bio, fullName: $fullName}';
  }

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object?> get props => [
        uid,
        email,
      ];
}
