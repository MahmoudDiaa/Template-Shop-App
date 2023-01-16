import 'package:flutter/material.dart';

import '../ui/constants/dimensions.dart';
import '../ui/dummy_data/gallery.dart';


class GalleryWidget extends StatefulWidget {
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: GalleryList.list().length,
        itemBuilder: (context, index){
          Gallery gallery = GalleryList.list()[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.heightSize),
            child: Image.asset(
              gallery.image,
              height: 220,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
