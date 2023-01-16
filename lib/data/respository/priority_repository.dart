import 'package:boilerplate/models/priority/priority_list.dart';
import '../../models/priority/priority.dart';

class PriorityRepository {
  PriorityRepository();

  Future<PriorityList> getPriorities() async {
    return PriorityList(priorities: <Priority>[
      Priority(id: 1, arabicName: 'منخفض', englishName: 'Low'),
      Priority(id: 2, arabicName: 'متوسط', englishName: 'Medium'),
      Priority(id: 3, arabicName: 'عالى', englishName: 'High'),
    ]);
  }
}
