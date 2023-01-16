import 'package:flutter/material.dart';

import '../ui/constants/custom_style.dart';
import '../ui/constants/dimensions.dart';
import '../ui/dummy_data/review.dart';
import 'my_rating.dart';




class ReviewWidget extends StatefulWidget {
  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize,
          top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: ReviewList.list().length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Review review = ReviewList.list()[index];
                  return Column(
                    children: [
                      SizedBox(height: Dimensions.heightSize,),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              child: Image.asset(
                                review.image,
                                height: 60,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.heightSize,),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.name,
                                  style: CustomStyle.defaultStyle,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${review.time} day ago',
                                      style: CustomStyle.textStyle,
                                    ),
                                    SizedBox(width: Dimensions.widthSize,),
                                    MyRating(rating: review.rating,),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize,),
                                Text(
                                  review.comment,
                                  style: CustomStyle.textStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.heightSize,),
                      Divider(color: Colors.black.withOpacity(0.1),)
                    ],
                  );
                }
            ),
          ),
          Row(
            children: [
              // Text(
              //   '4.5',
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: Dimensions.extraLargeTextSize * 2
              //   ),
              // ),
              // SizedBox(width: Dimensions.heightSize,),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       'Overall Rating',
              //       style: CustomStyle.defaultStyle,
              //     ),
              //     Row(
              //       children: [
              //         MyRating(rating: '5',),
              //         SizedBox(width: Dimensions.heightSize,),
              //         Text(
              //           'Excellent',
              //           style: CustomStyle.textStyle,
              //         ),
              //         Text(
              //           '(25)',
              //           style: CustomStyle.textStyle,
              //         ),
              //       ],
              //     )
              //   ],
              // ),
            ],
          ),
          // SizedBox(height: Dimensions.heightSize,),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: Row(
          //         children: [
          //           Text(
          //             'Environment',
          //             style: CustomStyle.textStyle,
          //           ),
          //           Text(
          //             '(5)',
          //             style: CustomStyle.textStyle,
          //           ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       flex: 2,
          //       child: Container(
          //         height: 7,
          //         decoration: BoxDecoration(
          //             color: CustomColor.primaryColor,
          //             borderRadius: BorderRadius.all(Radius.circular(2.5))
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: Dimensions.heightSize,),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: Row(
          //         children: [
          //           Text(
          //             'Services',
          //             style: CustomStyle.textStyle,
          //           ),
          //           Text(
          //             '(5)',
          //             style: CustomStyle.textStyle,
          //           ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       flex: 2,
          //       child: Container(
          //         height: 7,
          //         decoration: BoxDecoration(
          //             color: CustomColor.primaryColor,
          //             borderRadius: BorderRadius.all(Radius.circular(2.5))
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: Dimensions.heightSize,),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: Row(
          //         children: [
          //           Text(
          //             'Price',
          //             style: CustomStyle.textStyle,
          //           ),
          //           Text(
          //             '(5)',
          //             style: CustomStyle.textStyle,
          //           ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       flex: 2,
          //       child: Container(
          //         height: 7,
          //         decoration: BoxDecoration(
          //             color: CustomColor.primaryColor,
          //             borderRadius: BorderRadius.all(Radius.circular(2.5))
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: Dimensions.heightSize * 4,),
        ],
      ),
    );
  }
}
