import 'package:qlcv/model/task.dart';

class DataProc {
  static List<Task> tasks = [
    Task(
        title: 't1',
        description: 'd1',
        status: 'status',
        startDate: DateTime(2023, 2, 1),
        endDate: DateTime(2023, 2, 2)),
    Task(
        title: 't2',
        description: 'd2',
        status: 'status',
        startDate: DateTime(2023, 2, 2),
        endDate: DateTime(2023, 2, 2)),
  ];
}
