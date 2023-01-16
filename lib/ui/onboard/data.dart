

import '../constants/strings.dart';

class OnBoardingItem {
  final String title;
  final String subTitle;
  final String image;
  final String subImage;

  const OnBoardingItem({required this.title, required this.subTitle, required this.image, required this.subImage});
}

class OnBoardingItems {
  static List<OnBoardingItem> loadOnboardItem () {
    const fi = <OnBoardingItem> [
      OnBoardingItem(
        title: Strings.title1,
        subTitle: Strings.subTitle1,
        image: 'assets/images/onboard/1.png',
        subImage: 'assets/images/onboard/sub1.png',
      ),
      OnBoardingItem(
          title: Strings.title2,
          subTitle: Strings.subTitle2,
        image: 'assets/images/onboard/2.png',
        subImage: 'assets/images/onboard/sub2.png',
      ),
      OnBoardingItem(
          title: Strings.title3,
          subTitle: Strings.subTitle3,
          image: 'assets/images/onboard/3.png',
        subImage: 'assets/images/onboard/sub3.png',
      ),
    ];
    return fi;
  }
}