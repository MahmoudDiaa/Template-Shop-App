import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openGoogleMap(String latitude, String longitude) async {


    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri(path: googleUrl))) {
      await launchUrl(Uri(path: googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openAppleMap(String latitude, String longitude) async {
    String urlAppleMaps = 'https://maps.apple.com/?q=$latitude,$longitude';

    if (await canLaunchUrl(Uri(path: urlAppleMaps))) {
      await launchUrl(Uri(path: urlAppleMaps));
    } else {
      throw 'Could not open the map.';
    }
  }
}
