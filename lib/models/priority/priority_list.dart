
import 'package:boilerplate/models/priority/priority.dart';

class PriorityList {
  final List<Priority>? priorities;

  PriorityList({
    this.priorities,
  });

  factory PriorityList.fromJson(List<dynamic> json) {
    List<Priority> priorities = <Priority>[];
    priorities = json.map((post) => Priority.fromMap(post)).toList();

    return PriorityList(
      priorities: priorities,
    );
  }
}
