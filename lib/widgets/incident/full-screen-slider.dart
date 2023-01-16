import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../models/incident/incident_image.dart';
import '../../ui/constants/colors.dart';
import '../../utils/locale/app_localization.dart';

//https://pub.dev/packages/carousel_slider/example
class FullscreenSliderDemo extends StatelessWidget {
  List<IncidentImage> _incidentImage = [];

  String title;

  FullscreenSliderDemo(incidentImage, {String this.title = 'Image Slider'}) {
    _incidentImage = incidentImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: CustomColor.primaryColor,
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: false

                // autoPlay: false,
                ),
            items: _incidentImage
                .map((item) => Container(
                      child: Center(
                        child: PhotoView(
                          backgroundDecoration:
                              BoxDecoration(color: CustomColor.thirdColor),
                          imageProvider: NetworkImage(item.imageUrl ?? ''),
                        ),
                        //     Image.network(
                        //   item.imageUrl,
                        //   fit: BoxFit.cover,
                        //   height: height,
                        // )
                        //     CachedNetworkImage(
                        //   imageUrl: item.imageUrl ?? '',
                        //   fit: BoxFit.none,
                        //   height: height,
                        //   placeholder: (context, url) =>
                        //       Center(child: CircularProgressIndicator()),
                        //   errorWidget: (context, url, err) => Center(
                        //       child: Text(AppLocalizations.of(context)
                        //           .translate('tryLoadAgain'))),
                        // ),
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
