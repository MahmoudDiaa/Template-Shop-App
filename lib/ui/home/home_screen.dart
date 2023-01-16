import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../models/category/category.dart';
import '../../utils/locale/app_localization.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/categories_select.dart';
import '../../widgets/subcategories_select.dart';
import '../barber_details/barber_details_screen.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/strings.dart';
import '../dummy_data/barber.dart';
import '../dummy_data/near_by.dart';
import '../dummy_data/popular_category.dart';
import '../dummy_data/popular_parlour.dart';
import '../incident/incident_list_screen.dart';
import '../parlour_details/parlour_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  SharedPreferenceHelper? sharedPreferenceHelper;

  @override
  void didChangeDependencies() {
    sharedPreferenceHelper = GetIt.instance<SharedPreferenceHelper>();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _loadSharedPref();
  }

  _loadSharedPref() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/home_bg.png',
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: Dimensions.marginSize * 0.5,
                          right: Dimensions.marginSize * 0.5,
                          top: Dimensions.heightSize * 2,
                          bottom: Dimensions.heightSize * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // IconButton(
                          //   icon: Icon(
                          //     Icons.sort,
                          //     color: Colors.white,
                          //   ),
                          //   onPressed: () {},
                          // ),
                          Container(
                            height: 40,
                            width: 40,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // Container(
                                //     height: 40,
                                //     width: 40.0,
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         borderRadius:
                                //             BorderRadius.circular(20.0)),
                                //     child: Icon(
                                //       Icons.notifications_outlined,
                                //       color: CustomColor.primaryColor,
                                //     )),
                                // Positioned(
                                //   right: -5,
                                //   top: -5,
                                //   child: Container(
                                //     height: 20.0,
                                //     width: 20.0,
                                //     decoration: BoxDecoration(
                                //         color: CustomColor.primaryColor,
                                //         borderRadius:
                                //             BorderRadius.circular(10.0)),
                                //     child: Center(
                                //       child: Text(
                                //         '02',
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: Dimensions.smallTextSize),
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      //bottom: Dimensions.heightSize * 1,
                      top: Dimensions.marginSize,
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.list,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '${AppLocalizations.of(context).translate('hello')}: ${sharedPreferenceHelper?.authUser?.user?.fullName}  ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.extraLargeTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: Dimensions.heightSize * 0.5,
                          ),
                          Text(
                            '${sharedPreferenceHelper?.authUser?.user?.userName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.heightSize * 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // categoryWidget(context),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 370,
                //color: Colors.green,
                child: SingleChildScrollView(
                  child: CategoryFormField(
                    gridAndListHeight: MediaQuery.of(context).size.height - 370,
                    autoSelectFirstItem: true,
                    categoryListView:
                        CategoryListViewMode.SubCategoriesGroupedImageGrid,
                    //initialSelectedId: 8,
                    onCategoryChange: (category) {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => IncidentListScreen(
                      //       initialSubCategoryId: subCategory?.id,
                      //       showBack: true,
                      //       //initialSubCategoryId: e.id,
                      //     )));
                    },
                    onSubCategoryChange: (subCategory) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IncidentListScreen(
                                initialSubCategoryId: subCategory?.id,
                                showBack: true,
                                //initialSubCategoryId: e.id,
                              )));
                    },
                    onSaved: (category) {},
                    validator: (category) {},
                    // stream: categoryStreamController,
                    //initialValue: null,
                  ),
                  // SubCategoryFormField(
                  //   refreshDataBeforeGetting: false,
                  //   subcategoryListView:
                  //   SubCategoryListViewMode.ImageGridGrouped,
                  //   onChange: (subCategory) {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => IncidentListScreen(
                  //           initialSubCategoryId: subCategory?.id,
                  //           showBack: true,
                  //           //initialSubCategoryId: e.id,
                  //         )));
                  //   },
                  //   onSaved: (category) {},
                  //   validator: (category) {
                  //     // return _incidentFormStore.incident.categoryId ==
                  //     //     null
                  //     //     ? AppLocalizations.of(context)
                  //     //     .translate('selectSubCategory')
                  //     //     : null;
                  //   },
                  //   gridAndListHeight:
                  //   MediaQuery.of(context).size.height - 370,
                  //
                  //   //initialValue: null,
                  // ),,
                ),
              ),
              // popularParlourWidget(context),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              //popularCategoryWidget(context),
              // SizedBox(height: Dimensions.heightSize,),
              // nearByBeautyParlourWidget(context),
              // SizedBox(height: Dimensions.heightSize,),
              // chooseBarberWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  categoryWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize * 2, top: Dimensions.heightSize * 2),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: <Category>[
            Category(arabicName: 'test', englishName: 'test', id: 1)
          ].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Category category =
                Category(arabicName: 'test', englishName: 'test', id: 1);
            return Padding(
              padding: const EdgeInsets.only(right: Dimensions.widthSize * 3),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: CustomColor.secondaryColor,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Image.asset(category.icon ?? ''),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  Text(
                    category.arabicName ?? '',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  popularParlourWidget(BuildContext context) {
    return Container(
      height: 260,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(height: 200, child: Expanded(child: IncidentsMap())),
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.marginSize),
            child: Text(
              'آخر البلاغات',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Container(
              height: 210,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: PopularParlourList.list().length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  PopularParlour popularParlour =
                      PopularParlourList.list()[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: Dimensions.widthSize * 2),
                    child: GestureDetector(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 150,
                              width: 180,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius),
                                    child: Image.asset(
                                      popularParlour.image,
                                      height: 150,
                                      width: 180,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20.0,
                                    left: 10,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: CustomColor.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              Text(
                                                popularParlour.rating,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .smallTextSize,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.widthSize * 0.5,
                                        ),
                                        Container(
                                          height: 25,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: CustomColor.secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: Center(
                                            child: Text(
                                              popularParlour.status,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      Dimensions.smallTextSize,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  popularParlour.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Text(
                                  popularParlour.location,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.defaultTextSize,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ParlourDetailsScreen(
                                  name: popularParlour.name,
                                  image: popularParlour.image,
                                  location: popularParlour.location,
                                  rating: popularParlour.rating,
                                )));
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  popularCategoryWidget(BuildContext context) {
    return Container(
      height: 240,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.marginSize),
            child: Text(
              'أكثر الأقسام بلاغات',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: PopularCategoryList.list().length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  PopularCategory popularCategory =
                      PopularCategoryList.list()[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: Dimensions.widthSize * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius),
                          child: Image.asset(
                            popularCategory.image,
                            height: 130,
                            width: 150,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              popularCategory.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.extraSmallTextSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Dimensions.heightSize * 0.5,
                            ),
                            Text(
                              '${popularCategory.places} بلاغ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.extraSmallTextSize,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  nearByBeautyParlourWidget(BuildContext context) {
    return Container(
      height: 260,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Text(
              Strings.nearbyBeautyParlour,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.extraLargeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Container(
              height: 210,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: NearByList.list().length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  NearBy nearBy = NearByList.list()[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: Dimensions.widthSize * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 150,
                          width: 180,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius),
                                child: Image.asset(
                                  nearBy.image,
                                  height: 150,
                                  width: 180,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Positioned(
                                bottom: 20.0,
                                left: 10,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          Text(
                                            nearBy.rating,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    Dimensions.smallTextSize,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.widthSize * 0.5,
                                    ),
                                    Container(
                                      height: 25,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: CustomColor.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Center(
                                        child: Text(
                                          nearBy.status,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  Dimensions.smallTextSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nearBy.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.largeTextSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Dimensions.heightSize * 0.5,
                            ),
                            Text(
                              nearBy.location,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.defaultTextSize,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  chooseBarberWidget(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Text(
              Strings.chooseYourBarber,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.extraLargeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: BarberList.list().length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Barber barber = BarberList.list()[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: Dimensions.widthSize * 3),
                    child: GestureDetector(
                      child: Container(
                        height: 120,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image.asset(
                                barber.image,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.heightSize,
                            ),
                            Text(
                              barber.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BarberDetailsScreen(
                                  image: barber.image,
                                  name: barber.name,
                                  specialist: barber.specialist,
                                  rating: barber.rating,
                                  reviews: barber.reviews,
                                )));
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
