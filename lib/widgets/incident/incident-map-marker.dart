import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:intl/intl.dart';

import '../../constants/enums.dart';
import '../../models/incident/incident.dart';

class IncidentMarker extends Marker {
  Incident incident;

  IncidentMarker(
      {required this.incident,
      String localLanguage = 'ar',
      Function? InfoWindowOnTap})
      : super(
          markerId: MarkerId(incident.id!),
          position:
              LatLng(double.parse(incident.lat!), double.parse(incident.long!)),
          infoWindow: InfoWindow(
            onTap: () {
              if (InfoWindowOnTap != null) InfoWindowOnTap();
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => InidentDetailsScreen(
              //           incidentId: e?.id,
              //         )));
            },
            title: incident.localizedTitle(localLanguage),
            snippet:
                '${incident.localizedStatusName(localLanguage)} - ${DateFormat('dd/MM/yyyy').format(incident.createDate!)}',
          ),
          icon: incident.markerIcon,
        );
}
