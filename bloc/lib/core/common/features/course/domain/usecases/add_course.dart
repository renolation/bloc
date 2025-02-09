
import 'package:bloc_reno/core/common/features/course/domain/entities/course.dart';
import 'package:bloc_reno/core/common/features/course/domain/repos/course_repo.dart';
import 'package:bloc_reno/core/usecase/usecase.dart';
import 'package:bloc_reno/core/utils/typedefs.dart';

class AddCourse extends UseCaseWithParams<void, Course> {
  const AddCourse(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<void> call(Course params) async => _repo.addCourse(params);
}
