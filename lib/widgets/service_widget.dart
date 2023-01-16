import 'package:flutter/material.dart';

import '../ui/constants/colors.dart';
import '../ui/constants/custom_style.dart';
import '../ui/constants/dimensions.dart';
import '../ui/constants/strings.dart';
import '../ui/dummy_data/offers.dart';
import '../ui/dummy_data/services.dart';


class ServiceWidget extends StatefulWidget {
  @override
  _ServiceWidgetState createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    return detailsWidget(context);
  }
  detailsWidget(BuildContext context) {
    int totalPages = 2;
    return Column(
      children: [
        SizedBox(height: Dimensions.heightSize * 2,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 40,
                color: Colors.white,
                child: Center(
                  child: Text(
                    Strings.services,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 40,
                color: Colors.white,
                child: Center(
                  child: Text(
                    Strings.offers,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          color: Colors.white,
          child: PageView.builder(
              itemCount: totalPages,
              itemBuilder: (context, index) {
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 3,
                                color: index == 0 ? CustomColor.primaryColor : Colors.white,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 3,
                                color: index == 1 ? CustomColor.primaryColor : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: pageViewWidget(index),
                        )

                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }

  pageViewWidget(int index) {
    switch(index){
      case 0 :
        return servicesWidget(context);
      case 1:
        return offersWidget(context);
    }
  }

  servicesWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: ServicesList.list().length,
          itemBuilder: (context, index) {
            Services services = ServicesList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                  .marginSize, bottom: Dimensions.heightSize),
              child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(Dimensions.radius)
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        services.image,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: Dimensions.widthSize),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              services.name,
                              style: TextStyle(
                                fontSize: Dimensions.largeTextSize,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: Dimensions.heightSize * 0.5,),
                            Text(
                              '${services.service} Types',
                              style: CustomStyle.textStyle
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: Dimensions.widthSize),
                        child: Container(
                          height: 28,
                          width: 70,
                          decoration: BoxDecoration(
                              color: CustomColor.primaryColor,
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: Text(
                              Strings.book,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  offersWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: OffersList.list().length,
          reverse: true,
          itemBuilder: (context, index) {
            Offers offers = OffersList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                  .marginSize, bottom: Dimensions.heightSize),
              child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(Dimensions.radius)
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        offers.image,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: Dimensions.widthSize),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              offers.name,
                              style: TextStyle(
                                  fontSize: Dimensions.largeTextSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: Dimensions.heightSize * 0.5,),
                            Row(
                              children: [
                                Text(
                                    '${offers.discount}% Off ',
                                    style: CustomStyle.textStyle,
                                ),
                                Text(
                                    '\$${offers.oldPrice} ',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough
                                    ),
                                ),
                                Text(
                                    '\$${offers.newPrice}',
                                    style: CustomStyle.textStyle
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: Dimensions.widthSize),
                        child: Container(
                          height: 28,
                          width: 70,
                          decoration: BoxDecoration(
                              color: CustomColor.primaryColor,
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: Text(
                              Strings.book,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
