import 'incident.dart';

class IncidentList {
  List<Incident>? incidents;

  IncidentList({
    this.incidents,
  });

  appendItems(List<Incident> incidentsToAppend) {
    if (this.incidents == null)
      this.incidents = <Incident>[];
    else
      this.incidents!.addAll(incidentsToAppend);
  }

  factory IncidentList.fromJson(List<dynamic> json) {
    List<Incident> incidents = <Incident>[];
    incidents = json.map((post) => Incident.fromMap(post)).toList();

    return IncidentList(
      incidents: incidents,
    );
  }
}
