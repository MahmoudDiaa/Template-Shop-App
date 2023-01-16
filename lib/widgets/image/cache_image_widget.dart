import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  CachedImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
     this.height,
     this.width,
    required this.placeholder,
    required this.errorWidget,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;
  final BoxFit fit;
   double? height;
   double? width;
  final Widget placeholder;
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height,
      width: width,
      placeholder: (context, url) => placeholder ?? CircularProgressIndicator(),
      errorWidget: (context, url, err) =>
          errorWidget,
    );
  }
}
