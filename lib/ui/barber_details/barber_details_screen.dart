import 'package:flutter/material.dart';

import '../../widgets/my_rating.dart';
import '../../widgets/navigation/back_widget.dart';
import '../constants/colors.dart';
import '../constants/custom_style.dart';
import '../constants/dimensions.dart';
import '../constants/strings.dart';


class BarberDetailsScreen extends StatefulWidget {
  final String image, name, specialist, rating, reviews;

  const BarberDetailsScreen({Key? key, required this.image,required this.name,required this.specialist, required this.rating,required this.reviews}) : super(key: key);
  @override
  _BarberDetailsScreenState createState() => _BarberDetailsScreenState();
}

class _BarberDetailsScreenState extends State<BarberDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackWidget(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: CustomColor.accentColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius *
                        2), topRight: Radius.circular(Dimensions.radius * 2))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.heightSize * 3),
                      child: Text(
                        Strings.beautyExpert,
                        style: TextStyle(
                            fontSize: Dimensions.extraLargeTextSize * 1.2,
                            color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize,),
                    profileWidget(context),
                    aboutDetailsWidget(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  profileWidget(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            widget.image,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Text(
          widget.name,
          style: TextStyle(
              fontSize: Dimensions.extraLargeTextSize,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 0.5,),
        Text(
          widget.specialist,
          style: CustomStyle.textStyle,
        ),
        SizedBox(height: Dimensions.heightSize * 0.5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyRating(rating: widget.rating,),
            SizedBox(width: Dimensions.widthSize * 0.5,),
            Text(
              widget.rating,
              style: CustomStyle.textStyle,
            ),
            SizedBox(width: Dimensions.widthSize * 0.5,),
            Text(
              '(${widget.reviews})',
              style: CustomStyle.textStyle,
            ),
          ],
        ),
        SizedBox(height: Dimensions.heightSize),
        Container(
          height: 40.0,
          width: 120,
          decoration: BoxDecoration(
            color: CustomColor.primaryColor,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text(
              Strings.bookNow,
              style: TextStyle(
                  fontSize: Dimensions.largeTextSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
    );
  }

  aboutDetailsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.about,
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: Dimensions.heightSize * 0.5),
            Text(
              Strings.subTitle1,
              style: CustomStyle.textStyle,
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              Strings.openingHours,
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: Dimensions.heightSize * 0.5),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Mon - Wed',
                        style: CustomStyle.textStyle,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '8:00 am - 12:00 pm',
                        style: CustomStyle.textStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.heightSize * 0.5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Fri - Sat',
                        style: CustomStyle.textStyle,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '10:00 am - 11:00 pm',
                        style: CustomStyle.textStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              Strings.address,
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: Dimensions.heightSize * 0.5),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: CustomColor.primaryColor,
                      ),
                      Text(
                        '58 Street- al dulha london - USA',
                        style: CustomStyle.textStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions,
                        color: CustomColor.primaryColor,
                      ),
                      Text(
                        '5 KM',
                        style: CustomStyle.textStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
