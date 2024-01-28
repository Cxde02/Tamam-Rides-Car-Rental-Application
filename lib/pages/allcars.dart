import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homescreen/Components/fadeanimation.dart';
import 'package:homescreen/data/car.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/data/car2.dart';
import 'package:homescreen/pages/constant.dart';
import 'package:homescreen/pages/detail2.dart';
import 'package:provider/provider.dart';

class AllCars extends StatefulWidget {
  final Cars2 item;

  const AllCars({Key? key, required this.item}) : super(key: key);

  @override
  _AllCars createState() => _AllCars();
}

class _AllCars extends State<AllCars> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //Multiprovider is added so that the contents of 'Cars' can be accessed when using 'Consumer<Cars>'
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cars2>(create: (context) => Cars2()),
        ChangeNotifierProvider<Cars>(create: (context) => Cars()),
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
                    Center(
                        child: Text(
                      'Available Cars',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          //color: Color(0xffffffff),
                          /*shadows: const [
                        Shadow(
                          blurRadius: 10.0, // shadow blur
                          color:
                              Color.fromARGB(255, 46, 46, 46), // shadow color
                          offset:
                              Offset(1.0, 2.0), // how much shadow will be shown
                        ),
                      ],*/
                        ),
                      ),
                    )),
                    const SizedBox(height: 13),
                    Consumer<Cars2>(
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
                                    builder: (context) => DetailScreen2(
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
                                      date: item.cars[i].date,
                                      stars: item.cars[i].stars,
                                      cars: [],
                                      coord1: item.cars[i].coord1,
                                      coord2: item.cars[i].coord2,
                                      color: item.cars[i].color,
                                      mileage: item.cars[i].mileage,
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
