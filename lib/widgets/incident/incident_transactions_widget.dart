import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/incident/incident.dart';
import '../../ui/constants/colors.dart';
import '../../ui/constants/custom_style.dart';
import '../../ui/constants/dimensions.dart';
import '../../utils/locale/app_localization.dart';
import '../../utils/map/map_utils.dart';

class IncidentTransactionsWidget extends StatefulWidget {
  final Incident incident;

  const IncidentTransactionsWidget({Key? key, required this.incident})
      : super(key: key);

  @override
  _IncidentTransactionsWidgetState createState() => _IncidentTransactionsWidgetState();
}

class _IncidentTransactionsWidgetState extends State<IncidentTransactionsWidget> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          aboutWidget(context),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          // faqWidget(context),
          directionWidget(context),
          SizedBox(height: Dimensions.heightSize),
        ],
      ),
    );
  }

  aboutWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).translate('notes'),
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.defaultTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Center(
          child: Text(
            widget.incident.notes ??
                AppLocalizations.of(context).translate('noNotes'),
            style: CustomStyle.textStyle,
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
      ],
    );
  }

  faqWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FAQ',
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.defaultTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  child: ExpansionTile(
                    backgroundColor: Colors.white,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '0${(index + 1).toString()}. ',
                          style: CustomStyle.textStyle,
                        ),
                        Text(
                          'Rorem Ipsum is nosimplyrandom text',
                          style: CustomStyle.textStyle,
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Dimensions.marginSize,
                            right: Dimensions.marginSize,
                            bottom: Dimensions.heightSize),
                        child: ListTile(
                          title: Text(
                            'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. ',
                            style: CustomStyle.textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  directionWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).translate('incidentLocation'),
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.defaultTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Container(
          height: 150.0,
          child: (widget.incident.lat != null && widget.incident.long != null)
              ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(widget.incident.lat ?? ''),
                        double.parse(widget.incident.long ?? '')),
                    zoom: 9.0,
                  ),
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(<Marker>[]),
                  onMapCreated: (GoogleMapController controller) {
                    //_controller.complete(controller);
                  },
                  onTap: (latlong) async {
                    await _openMaps();
                  },
                )
              : Center(
                  child: Text(AppLocalizations.of(context)
                      .translate('incidentLocationNotAvailable'))),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Row(
          children: widget.incident.districtName != null
              ? [
                  Icon(
                    Icons.location_on,
                    color: CustomColor.primaryColor,
                  ),
                  SizedBox(
                    width: Dimensions.widthSize * 0.5,
                  ),
                  Flexible(
                    child: Text('${widget.incident.districtName}'),
                  ),
                ]
              : [],
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Row(children: [
          TextButton.icon(
              onPressed: () {
                _openMaps();
              },
              icon: Icon(
                Icons.map,
                color: CustomColor.primaryColor,
              ),
              label: Text(
                  AppLocalizations.of(context).translate('openGoogleMap'))),
        ]),
      ],
    );
  }

  Future<void> _openMaps() async {
    // try {
    //   final availableMaps = await map_launcher.MapLauncher.installedMaps;
    //   // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
    //   print(availableMaps);
    //   if (widget.incident.lat != null && widget.incident.long != null)
    //     await availableMaps.first.showMarker(
    //       coords: map_launcher.Coords(double.parse(widget.incident.lat!),
    //           double.parse(widget.incident.long!)),
    //       title: widget.incident.address ?? 'Incident Address',
    //     );
    // } catch (d) {}
  }
}
