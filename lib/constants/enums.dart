import 'package:boilerplate/data/network/constants/endpoints.dart';

enum CategoryListViewMode { List, Radiobutton,SubCategoriesGroupedImageGrid }

enum SubCategoryListViewMode { ImageList, ImageGrid,ImageGridGrouped, Radiobutton }

enum PriorityListViewMode { List, Radiobutton }

enum IncidentListViewMode { List, Radiobutton }

enum AuthScreenMode { Login, SignUp, ChangePassword }

enum IncidentStatusEnum {
  New,
  Assigned,
  Solved,
  Upped,
  SolvedInitially,
  Unkown
}

extension IncidentStatusExtension on IncidentStatusEnum {
  int? get id {
    switch (this) {
      case IncidentStatusEnum.Assigned:
        return 2;
      case IncidentStatusEnum.Solved:
        return 3;
      case IncidentStatusEnum.New:
        return 1;
      case IncidentStatusEnum.SolvedInitially:
        return 5;
      case IncidentStatusEnum.Upped:
        return 4;
      default:
        return null;
    }
  }

  String? get workflowSubmitEndpointName {
    switch (this) {
      case IncidentStatusEnum.Assigned:
        return Endpoints.baseUrl1 + "/Incidents/Assign";
      case IncidentStatusEnum.Solved:
        return Endpoints.baseUrl1 + "/Incidents/FinallyDone";
      case IncidentStatusEnum.New:
        return null;
      case IncidentStatusEnum.SolvedInitially:
        return Endpoints.baseUrl1 + "/Incidents/DoneInitially";
      case IncidentStatusEnum.Upped:
        return Endpoints.baseUrl1 + "/Incidents/Taseed";
      default:
        return null;
    }
  }
}
