import 'package:flutter/cupertino.dart';
import 'package:homescreen/Components/fadeanimation.dart';
import 'package:homescreen/data/car.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/data/car2.dart';
import 'package:homescreen/pages/allcars.dart';
import 'package:homescreen/pages/constant.dart';
import 'package:homescreen/pages/detail.dart';
import 'package:provider/provider.dart';

class RecentlyRented extends StatefulWidget {
  final Cars item;

  const RecentlyRented({Key? key, required this.item}) : super(key: key);

  @override
  _RecentlyRentedState createState() => _RecentlyRentedState();
}

class _RecentlyRentedState extends State<RecentlyRented> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //Multiprovider is added so that the contents of 'Cars' can be accessed when using 'Consumer<Cars>'
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cars>(create: (context) => Cars()),
        ChangeNotifierProvider<Cars2>(create: (context) => Cars2()),
      ],
      child: Scaffold(
        //backgroundColor: Color(0xFF003265),
        body: SafeArea(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: size.width * 0.1,
                      width: size.width * 0.1,
                      margin: const EdgeInsets.fromLTRB(16, 20, 0, 18),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                        ],
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(CupertinoIcons.back),
                        //child: Image.asset('assets/images/back-arrow.png'),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Hot Deals',
                            style: kSectionTitle.copyWith(fontSize: 25)),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 67)),
                        Consumer<Cars2>(
                          builder: (context, item, _) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AllCars(
                                    item: item,
                                  ),
                                ),
                              );
                            },
                            /*child: const Text(
                              'More Details',
                              style: kViewAll,
                            ),*/
                            child: ElevatedButton.icon(
                              onPressed: (null),
                              icon: Icon(
                                Icons.visibility,
                                color: Colors.white,
                              ),
                              label: Text(
                                'View All',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat'),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                /*backgroundColor:
                                    MaterialStatePropertyAll(Color(0xFF2E8970)),*/
                                elevation:
                                    MaterialStateProperty.all<double>(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Consumer<Cars>(
                      builder: (context, item, _) => SizedBox(
                        height: size.height * 0.8,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.item.cars.length,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      name: item.cars[i].name,
                                      model: item.cars[i].model,
                                      brand: item.cars[i].brand,
                                      imageUrl: item.cars[i].imageUrl,
                                      imageUrl1: item.cars[i].imageUrl1,
                                      imageUrl2: item.cars[i].imageUrl2,
                                      description: item.cars[i].description,
                                      speed: item.cars[i].speed,
                                      seats: item.cars[i].seats,
                                      engine: item.cars[i].engine,
                                      price: item.cars[i].price,
                                      priceW: item.cars[i].priceW,
                                      priceM: item.cars[i].priceM,
                                      trans: item.cars[i].trans,
                                      fuel: item.cars[i].fuel,
                                      cc: item.cars[i].cc,
                                      color1: item.cars[i].color1,
                                      color2: item.cars[i].color2,
                                      color3: item.cars[i].color3,
                                      location: item.cars[i].location,
                                      stars: item.cars[i].stars,
                                      cars: [],
                                      color: item.cars[i].color,
                                      date: item.cars[i].date,
                                      mileage: item.cars[i].mileage,
                                      coord1: item.cars[i].coord1,
                                      coord2: item.cars[i].coord2,
                                      chooseC1: item.cars[i].chooseC1,
                                      chooseC2: item.cars[i].chooseC2,
                                      chooseC3: item.cars[i].chooseC3,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: size.height * 0.45,
                                width: size.width - 32,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 20),
                                padding:
                                    const EdgeInsets.fromLTRB(16, 11, 8, 10),
                                /*decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                      color: Color(0xFF0a468d), width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),*/
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 2), // horizontal, vertical offset
                                    ),
                                  ],
                                  color: Theme.of(context).primaryColor,
                                  //color: kShadeColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                  /*border: Border.all(
                                  color: Color(0xFF0A486D), width: 2),*/
                                ),
                                child: Column(
                                  children: [
                                    FadeAnimation(
                                      delay: 0.1,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.item.cars[i].name +
                                                    ' ' +
                                                    widget.item.cars[i].model,
                                                style: kBrand,
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/images/star2.png'),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    widget.item.cars[i].stars,
                                                    style: kRate.apply(
                                                        /*color: kTextColor2
                                                          .withOpacity(0.6),*/
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0),
                                            child: Container(
                                                height: size.width * 0.1,
                                                width: size.width * 0.1,
                                                decoration: BoxDecoration(
                                                  /* boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.5), // Shadow color
                                                spreadRadius: 1, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: Offset(0,
                                                    4), // Offset in x and y direction
                                              ),
                                            ],*/
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  CupertinoIcons
                                                      .arrow_up_right_circle_fill,
                                                  color: Color(0xFF0A486D),
                                                ) /*Image.asset(
                                            'assets/images/active-saved.png'),*/
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeAnimation(
                                      delay: 0.3,
                                      child: Center(
                                        child: Hero(
                                          tag: widget.item.cars[i].imageUrl,
                                          child: Image.asset(
                                            scale: 2.5,
                                            widget.item.cars[i].imageUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FadeAnimation(
                                          delay: 0.5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/cost.png',
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Cost',
                                                    style: kCarDetails.copyWith(
                                                        /*color: kTextColor
                                                            .withOpacity(0.8),*/
                                                        fontFamily: 'Barlow',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Rs '
                                                '${widget.item.cars[i].price.toStringAsFixed(0)} / day',
                                                style: kCarDetails.copyWith(
                                                    //color: kTextColor,
                                                    fontFamily: 'Barlow',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        FadeAnimation(
                                          delay: 0.6,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/date.png',
                                                  ),
                                                  const SizedBox(width: 9),
                                                  Text(
                                                    'Year',
                                                    style: kCarDetails.copyWith(
                                                        /*color: kTextColor
                                                            .withOpacity(0.8),*/
                                                        fontFamily: 'Barlow',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                widget.item.cars[i].date,
                                                style: kCarDetails.copyWith(
                                                    //color: kTextColor,
                                                    fontFamily: 'Barlow',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        FadeAnimation(
                                          delay: 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/duration.png',
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Mileage',
                                                    style: kCarDetails.copyWith(
                                                        /*color: kTextColor
                                                            .withOpacity(0.8),*/
                                                        fontFamily: 'Barlow',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                widget.item.cars[i].mileage,
                                                style: kCarDetails.copyWith(
                                                    //color: kTextColor,
                                                    fontFamily: 'Barlow',
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        FadeAnimation(
                                          delay: 0.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/color.png',
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Colors +',
                                                    style: kCarDetails.copyWith(
                                                        /*color: kTextColor
                                                            .withOpacity(0.8),*/
                                                        fontFamily: 'Barlow',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    widget.item.cars[i].color1,
                                                    scale: 25,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Image.asset(
                                                    widget.item.cars[i].color2,
                                                    scale: 25,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Image.asset(
                                                    widget.item.cars[i].color3,
                                                    scale: 25,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        /*const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '(' +
                                                  widget.item.cars[i].price +
                                                  '/week)',
                                              style: kCarDetails.copyWith(
                                                  color: kTextColor
                                                      .withOpacity(0.6)),
                                            ),
                                          ],
                                        ),*/
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
