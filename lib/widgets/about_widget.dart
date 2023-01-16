import 'package:flutter/material.dart';

import '../ui/constants/colors.dart';
import '../ui/constants/custom_style.dart';
import '../ui/constants/dimensions.dart';
import '../ui/constants/strings.dart';
import 'google_map/custom_google_map.dart';

class AboutWidget extends StatefulWidget {
  @override
  _AboutWidgetState createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize,
          top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          aboutWidget(context),
          SizedBox(height: Dimensions.heightSize,),
          faqWidget(context),
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
          'Why Choose Us',
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.defaultTextSize,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Text(
          'Contrary to popular belief, Lorem Ipsum is nosimplyrandom text. It has roots in a piece of classical Latin literature 45 BC, making it over 2000 years old',
          style: CustomStyle.textStyle,
        ),
        SizedBox(height: Dimensions.heightSize,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Strings.bullet,
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize * 2,
                  color: CustomColor.primaryColor
              ),
            ),
            SizedBox(width: Dimensions.heightSize,),
            Expanded(
              child: Text(
                'Distracted by the readable content of a page when looking at its layout',
                style: CustomStyle.textStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.heightSize,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Strings.bullet,
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize * 2,
                  color: CustomColor.primaryColor
              ),
            ),
            SizedBox(width: Dimensions.heightSize,),
            Expanded(
              child: Text(
                'Distracted by the readable content of a page when looking at its layout',
                style: CustomStyle.textStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.heightSize,),
        Text(
          'Our Mission and Vision',
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.defaultTextSize,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Text(
          'Contrary to popular belief, Lorem Ipsum is nosimplyrandom text. It has roots in a piece of classical Latin literature 45 BC, making it over 2000 years old',
          style: CustomStyle.textStyle,
        ),
        SizedBox(height: Dimensions.heightSize,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Strings.bullet,
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize * 2,
                  color: CustomColor.primaryColor
              ),
            ),
            SizedBox(width: Dimensions.heightSize,),
            Expanded(
              child: Text(
                'Distracted by the readable content of a page when looking at its layout',
                style: CustomStyle.textStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.heightSize,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Strings.bullet,
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize * 2,
                  color: CustomColor.primaryColor
              ),
            ),
            SizedBox(width: Dimensions.heightSize,),
            Expanded(
              child: Text(
                'Distracted by the readable content of a page when looking at its layout',
                style: CustomStyle.textStyle,
              ),
            ),
          ],
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
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Card(
                  elevation: 1,
                  child: ExpansionTile(
                    backgroundColor: Colors.white,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '0${(index+1).toString()}. ',
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
                        padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                            .marginSize, bottom:
                        Dimensions.heightSize),
                        child:  ListTile(
                          title: Text(
                            'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. ',
                            style: CustomStyle.textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  directionWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.salonDestination,
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.defaultTextSize,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Container(
          height: 150.0,
          child: CustomGoogleMap.map,
        ),
        SizedBox(height: Dimensions.heightSize,),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: CustomColor.primaryColor,
            ),
            SizedBox(width: Dimensions.widthSize * 0.5,),
            Text(
              '58 Street18c - al dulha 3, London - United USA'
            )
          ],
        ),
        SizedBox(height: Dimensions.heightSize,),
        Row(
          children: [
            Icon(
              Icons.bus_alert,
              color: CustomColor.primaryColor,
            ),
            SizedBox(width: Dimensions.widthSize * 0.5,),
            Text(
              '10 min By Bus without traffic'
            )
          ],
        ),
      ],
    );
  }


}
