
import 'package:bloc_reno/core/common/features/course/domain/entities/course.dart';
import 'package:bloc_reno/core/common/features/course/domain/repos/course_repo.dart';
import 'package:bloc_reno/core/usecase/usecase.dart';
import 'package:bloc_reno/core/utils/typedefs.dart';

class GetCourses extends UseCaseWithoutParams<List<Course>> {
  const GetCourses(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<List<Course>> call() async => _repo.getCourses();
}
