import 'dart:async';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'dart:io' show Platform;

import '../../constants/strings.dart';
import '../../utils/locale/app_localization.dart';

// Your api key storage.
// import 'keys.dart';

class PlacePickerWidget extends StatefulWidget {
  Function(PickResult?) onPlaceChange;
  String loadMapBtnPopupText;
  String loadMapBtnContainerText;

  bool showMapInDialog;

  PickResult? initialMapPlace;

  PlacePickerWidget(
      {required this.loadMapBtnPopupText,
      required this.loadMapBtnContainerText,
      required this.showMapInDialog,
      required this.onPlaceChange,
      this.initialMapPlace})
      : super();

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _PlacePickerWidgetState createState() => _PlacePickerWidgetState();
}

class _PlacePickerWidgetState extends State<PlacePickerWidget> {
  PickResult? selectedPlace;
  bool showGoogleMapInContainer = false;
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    if (!initialized && widget.initialMapPlace != null) {
      _onPlaceChange(widget.initialMapPlace);
      initialized = true;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget.showMapInDialog ? showMapInDialogWidget(context) : Container(),
        !widget.showMapInDialog
            ? showMapInContainerWidget(context)
            : Container(),
        selectedPlace == null
            ? Container()
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    selectedPlace?.formattedAddress ?? "Please get your place",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        // StreamBuilder<PickResult?>(
        //   stream: _locationStreamController.stream,
        //   builder: (context, snapthot) {
        //     if (snapthot.data == null) return Container();
        //     var aa = CameraPosition(
        //       target: LatLng(snapthot.data!.geometry!.location!.lat,
        //           snapthot.data!.geometry!.location!.lng),
        //       zoom: 9.0,
        //     );
        //     return Container(
        //       height: 150,
        //       child: new GoogleMap(
        //         // scrollGesturesEnabled: false,
        //         // zoomControlsEnabled: false,
        //         // zoomGesturesEnabled: false,
        //         initialCameraPosition: aa,
        //
        //         mapType: MapType.normal,
        //         markers: Set<Marker>.of(<Marker>[
        //           Marker(
        //             markerId: MarkerId(DateTime.now().microsecond.toString()),
        //             position: LatLng(snapthot.data!.geometry!.location!.lat,
        //                 snapthot.data!.geometry!.location!.lng),
        //           )
        //         ]),
        //         onMapCreated: (GoogleMapController controller) {
        //           //_controller.complete(controller);
        //         },
        //         onTap: (latlong) {},
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }

  Widget showMapInDialogWidget(BuildContext context) {
    return !showGoogleMapInContainer
        ? IconButton(
            iconSize: 50,
            // child: Text('${widget.loadMapBtnPopupText}'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PlacePicker(
                      apiKey: Platform.isAndroid
                          ? Strings.androidApiKey
                          : Strings.iosApiKey,
                      hintText:
                          AppLocalizations.of(context).translate('findAPlace'),
                      searchingText:
                          AppLocalizations.of(context).translate('pleaseWait'),
                      selectText:
                          AppLocalizations.of(context).translate('selectPlace'),
                      outsideOfPickAreaText: AppLocalizations.of(context)
                          .translate('placeNotInArea'),
                      initialPosition: PlacePickerWidget.kInitialPosition,
                      useCurrentLocation: true,
                      selectInitialPosition: true,
                      usePinPointingSearch: true,
                      usePlaceDetailSearch: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      onPlacePicked: (PickResult result) {
                        setState(() {
                          _onPlaceChange(result);
                          Navigator.of(context).pop();
                        });
                      },
                      onMapTypeChanged: (MapType mapType) {
                        print("Map type changed to ${mapType.toString()}");
                      },
                    );
                  },
                ),
              );
            },
            icon: Icon(
              Icons.pin_drop,
              color: CustomColor.primaryColor,
            ),
          )
        : Container();
  }

  StreamController<PickResult?> _locationStreamController =
      StreamController<PickResult?>();

  void _onPlaceChange(PickResult? result) {
    selectedPlace = result;
    widget.onPlaceChange(selectedPlace);
    _locationStreamController.add(selectedPlace);
  }

  Widget showMapInContainerWidget(BuildContext context) {
    return !showGoogleMapInContainer
        ? ElevatedButton(
            child: Text('${widget.loadMapBtnContainerText}'),
            onPressed: () {
              setState(() {
                showGoogleMapInContainer = true;
              });
            },
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.4,
            child: PlacePicker(
                apiKey: Platform.isAndroid
                    ? Strings.androidApiKey
                    : Strings.iosApiKey,
                hintText: AppLocalizations.of(context).translate('findAPlace'),
                searchingText:
                    AppLocalizations.of(context).translate('pleaseWait'),
                selectText:
                    AppLocalizations.of(context).translate('selectPlace'),
                outsideOfPickAreaText:
                    AppLocalizations.of(context).translate('placeNotInArea'),
                initialPosition: PlacePickerWidget.kInitialPosition,
                useCurrentLocation: true,
                selectInitialPosition: true,
                usePinPointingSearch: true,
                usePlaceDetailSearch: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                onPlacePicked: (PickResult result) {
                  setState(() {
                    _onPlaceChange(result);
                    showGoogleMapInContainer = false;
                  });
                },
                onTapBack: () {
                  setState(() {
                    showGoogleMapInContainer = false;
                  });
                }));
  }
}
