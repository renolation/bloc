
import 'package:bloc_reno/core/common/features/course/domain/entities/course.dart';
import 'package:bloc_reno/core/utils/typedefs.dart';

abstract class CourseRepo {
  const CourseRepo();

  ResultFuture<List<Course>> getCourses();

  ResultFuture<void> addCourse(Course course);
}
