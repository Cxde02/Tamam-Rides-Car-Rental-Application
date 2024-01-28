import 'package:flutter/material.dart';
import 'package:homescreen/pages/detail2.dart';

class CookiePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          //SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 2.05,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard(
                      'assets/images/toyotalogo.png',
                      'Vitz XP10',
                      'Toyota',
                      'The Mauritius Co-operative Agricultural Federation Ltd - Branch Union Park',
                      'assets/images/toyotavitz.png',
                      'assets/images/toyotavitz1.png',
                      'assets/images/toyotavitz2.png',
                      'With a curb weight of 2072 lbs (940 kgs), the Vitz XP10 1.5RS has a naturally-aspirated Inline 4 cylinder engine, Petrol motor, with the engine code 1NZ-FE.',
                      '215 km/h',
                      '5',
                      '1.5 RS',
                      '4.5',
                      1000,
                      6350,
                      25400,
                      '2007',
                      '250,000 Km',
                      'Manual',
                      'Petrol',
                      '1298',
                      'Yellow',
                      'assets/images/red.png',
                      'assets/images/blue.png',
                      'assets/images/orange.png',
                      -20.389734592335113,
                      57.583484500695846,
                      'assets/images/toyotavitzc1.png',
                      'assets/images/toyotavitzc2.png',
                      'assets/images/toyotavitzc3.png',
                      context),
                  _buildCard(
                      'assets/images/hondalogo.png',
                      'Fit 2020',
                      'Honda',
                      'Wazaabi Sushi Beau Bassin, Barkly Street, Beau Bassin-Rose Hill',
                      'assets/images/hondafit.png',
                      'assets/images/hondafit1.png',
                      'assets/images/hondafit2.png',
                      'The Honda Fit is a front-wheel-drive hatchback that seats up to five. It has a 130-horsepower, 1.5-liter four-cylinder engine that pairs with a six-speed manual or continuously variable automatic transmission',
                      '300 km/h',
                      '5',
                      '1.5 N15',
                      '4.7',
                      1200,
                      6000,
                      24000,
                      '2012',
                      '150,000 Km',
                      'Automatic',
                      'Petrol',
                      '1498',
                      'Black',
                      'assets/images/green.png',
                      'assets/images/blue.png',
                      'assets/images/purple.png',
                      -20.225521339274614,
                      57.46384820862934,
                      'assets/images/hondafitc1.png',
                      'assets/images/hondafitc2.png',
                      'assets/images/hondafitc3.png',
                      context),
                  _buildCard(
                      'assets/images/mazdalogo.png',
                      '3 2016',
                      'Mazda',
                      'Car Rental Rose Belle, Saint Jean Road',
                      'assets/images/mazda3.png',
                      'assets/images/mazda31.png',
                      'assets/images/mazda32.png',
                      'For the 2016 Mazda 3, the SV trim level has been dropped, so the 3i Sport trim is now the base model. Mazda has also added more standard features this year. A rearview camera is on every Mazda 3, while automatic headlights, automatic wipers and a sunroof are standard on trim levels higher than Sport.',
                      '220 km/h',
                      '5',
                      '1.5 L4',
                      '4.2',
                      1350,
                      9100,
                      36350,
                      '2016',
                      '145,000 Km',
                      'Automatic',
                      'Petrol',
                      '1500',
                      'Red',
                      'assets/images/green.png',
                      'assets/images/black.png',
                      'assets/images/yellow.png',
                      -20.258300551063904,
                      57.488294793433674,
                      'assets/images/mazda3c1.png',
                      'assets/images/mazda3c2.png',
                      'assets/images/mazda3c3.png',
                      context),
                  _buildCard(
                      'assets/images/toyotalogo.png',
                      'Aqua NHP10',
                      'Toyota',
                      'Sixt Rent a Car — Quatre Bornes, Quatre Bornes, Mauritius',
                      'assets/images/toyotaaqua.png',
                      'assets/images/toyotaaqua1.png',
                      'assets/images/toyotaaqua2.png',
                      'The Toyota Aqua is a popular used car among kiwi buyers. It’s a compact, front-wheel-drive, hybrid hatchback that the Japanese manufacturer first launched back in December 2011.',
                      '180 km/h',
                      '5',
                      '1,5 XP21',
                      '4.9',
                      1200,
                      8300,
                      33500,
                      '2015',
                      '74,000 Km',
                      'Automatic',
                      'Petrol',
                      '1500',
                      'Green',
                      'assets/images/white.png',
                      'assets/images/blue.png',
                      'assets/images/pink.png',
                      -20.266896801671837,
                      57.477155277408535,
                      'assets/images/toyotaaquac3.png',
                      'assets/images/toyotaaquac1.png',
                      'assets/images/toyotaaquac2.png',
                      context),
                  _buildCard(
                      'assets/images/SUZUKILOGO.png',
                      'Alto K10',
                      'Suzuki',
                      'Sixt Rent a Car — Quatre Bornes, Quatre Bornes, Mauritius',
                      'assets/images/suzukialto.png',
                      'assets/images/suzukialto1.png',
                      'assets/images/suzukialto2.png',
                      'The Alto K10 is powered by a one-litre, three-cylinder, all-aluminium motor that is now the mainstay of Maruti’s entry-level range. The new engine has been updated to meet the latest emission norms, including the stricter BS6 Phase 2 standards, which come into effect next April. The Alto K10 comes with two transmission options, a five-speed manual and a five-speed automated manual transmission which Maruti calls AGS (for Auto Gear Shift). The manual makes the most of the feisty 67hp motor ',
                      '160 Km/h',
                      '5',
                      '1.0 K10C',
                      '3.9',
                      900,
                      6200,
                      24000,
                      '2016',
                      '120,000 Km',
                      'Manual',
                      'Petrol',
                      '990',
                      'Red',
                      'assets/images/blue.png',
                      'assets/images/black.png',
                      'assets/images/white.png',
                      -20.266977318493282,
                      57.477069446721664,
                      'assets/images/suzukialtoc1.png',
                      'assets/images/suzukialtoc2.png',
                      'assets/images/suzukialtoc3.png',
                      context),
                  _buildCard(
                      'assets/images/kialogo.png',
                      'Picanto 2019',
                      'Kia',
                      'Winner\'s Vacoas, Vacoas-Phoenix',
                      'assets/images/kiapicanto.png',
                      'assets/images/kiapicanto1.png',
                      'assets/images/kiapicanto2.png',
                      'As with many Kias, the transformation of the Picanto from the drab and sparse first generation car to this Mk3 model is a big one. Building on the stylish design of the Picanto Mk2, the South Korean city car delivers a higher quality and better equipped interior, more space, a grown-up driving experience and extra personalisation. Kia even offers an SUV-style X-Line model for those after the crossover look.',
                      '180 km/h',
                      '5',
                      '1.2 AO',
                      '4.8',
                      1100,
                      7500,
                      29000,
                      '2019',
                      '1 week',
                      'Automatic',
                      'Petrol',
                      '1200',
                      'Grey',
                      'assets/images/red.png',
                      'assets/images/blue.png',
                      'assets/images/black.png',
                      -20.333975018454915,
                      57.50612707502446,
                      'assets/images/kiapicantoc1.png',
                      'assets/images/kiapicantoc2.png',
                      'assets/images/kiapicantoc3.png',
                      context),
                  _buildCard(
                      'assets/images/nissanlogo.png',
                      'Micra 2015',
                      'Nissan',
                      'Archery CSSC Clubhouse (Curepipe Starlight Sporting Club), Curepipe',
                      'assets/images/nissanmicra.png',
                      'assets/images/nissanmicra1.png',
                      'assets/images/nissanmicra2.png',
                      'Nissan heavily revised fourth generation Micra supermini turned over a new leaf in 2013. As before, it was impressively space efficient and offered the option of a clever supercharged 1.2-litre petrol engine that was not only eager but also both frugal and green. It may be sensible rather than sporty, but this very affordable contender delivers in exactly the areas a small car should.',
                      '200 Km/h',
                      '5',
                      '1.2 HR12',
                      '4.7',
                      1100,
                      7600,
                      30350,
                      '2015',
                      '215,000 Km',
                      'Automatic',
                      'Petrol',
                      '1200',
                      'Black',
                      'assets/images/red.png',
                      'assets/images/blue.png',
                      'assets/images/green.png',
                      -20.333975018454915,
                      57.50612707502446,
                      'assets/images/nissanmicrac1.png',
                      'assets/images/nissanmicrac2.png',
                      'assets/images/nissanmicrac3.png',
                      context),
                  _buildCard(
                      'assets/images/hyundailogo.png',
                      'Creta N Line 2023',
                      'Hyundai',
                      'Bassin Carangue Little Beach, L\'Escalier',
                      'assets/images/hyundaikreta.png',
                      'assets/images/hyundaikreta1.png',
                      'assets/images/hyundaikreta2.png',
                      'Creta is an all-rounder car and the best in the segment. Diesel mileage is around 24 on the highway. Performance is very good on hills. The suspension setup is better than seltos. The cabin is very silent with good insulation. The only problem is that the 8 inches screen does not come with wired Apple car play. Using wireless car play is not efficient every time.',
                      '280 km/h',
                      '5',
                      '1.5 M.P.I',
                      '4.3',
                      1500,
                      10000,
                      39000,
                      '2023',
                      '56,000 Km',
                      'Automatic',
                      'Diesel',
                      '1500',
                      'White',
                      'assets/images/orange.png',
                      'assets/images/blue.png',
                      'assets/images/black.png',
                      -20.49491413615615,
                      57.62337085043184,
                      'assets/images/hyundaikretac1.png',
                      'assets/images/hyundaikretac2.png',
                      'assets/images/hyundaikretac3.png',
                      context),
                  _buildCard(
                      'assets/images/peugeotlogo.png',
                      '2008 GT Line',
                      'Peugeot',
                      'Bois-Cheri Football Field, Bois Cheri Road, Bois Cheri',
                      'assets/images/peugeot2008.png',
                      'assets/images/peugeot20082.png',
                      'assets/images/peugeot20083.png',
                      'It is a little. Are you sitting down? The petrol GT will set you back a whopping £31,350, a whisker under £500 a month if you opt for finance. Peugeot’s thrown everything at the top-spec model, with wireless phone charging, panoramic sunroof, adaptive cruise control with lane-keep assist, keyless entry and a host of other goodies.',
                      '200 km/h',
                      '5',
                      '1.2 3E',
                      '4.9',
                      1350,
                      9400,
                      37500,
                      '2008',
                      '230,000 Km',
                      'Automatic',
                      'Petrol',
                      '1200',
                      'Orange',
                      'assets/images/red.png',
                      'assets/images/blue.png',
                      'assets/images/grey.png',
                      -20.429586646954917,
                      57.536977529532976,
                      'assets/images/peugeot2008c1.png',
                      'assets/images/peugeot2008c2.png',
                      'assets/images/peugeot2008c3.png',
                      context),
                  _buildCard(
                      'assets/images/hondalogo.png',
                      'Jazz 2023',
                      'Honda',
                      'Morcellement St Andre C.C, Port Louis',
                      'assets/images/hondajazz.png',
                      'assets/images/hondajazz1.png',
                      'assets/images/hondajazz2.png',
                      'Honda made a splash in the B-segment when it launched the original Jazz nearly two decades ago. The concept of a hatchback with a sprinkling of multi-purpose vehicle versatility instantly took off.Its tallish roof and practical interior dimensions made for a companion that suited all manner of lifestyles, enhanced by features such as rear seats that could be configured in seemingly endless ways. ',
                      '180 km/h',
                      '5',
                      'L12B',
                      '4.5',
                      1100,
                      7600,
                      30400,
                      '2022',
                      '54,000 Km',
                      'Automatic',
                      'Petrol',
                      '1200',
                      'Dark Grey',
                      'assets/images/red.png',
                      'assets/images/blue.png',
                      'assets/images/grey.png',
                      -20.067555664372684,
                      57.56944219459583,
                      'assets/images/hondajazzc1.png',
                      'assets/images/hondajazzc2.png',
                      'assets/images/hondajazzc3.png',
                      context),
                  _buildCard(
                      'assets/images/toyotalogo.png',
                      'Yaris 2017',
                      'Toyota',
                      'Le Cap Car Hire Ltd, Cap Malheureux',
                      'assets/images/toyotayaris.png',
                      'assets/images/toyotayaris1.png',
                      'assets/images/toyotayaris2.png',
                      'The Toyota Yaris is one of the brand’s best-selling models, and in the UK it competes with the hugely popular Ford Fiesta, Vauxhall Corsa and VW Polo models in the supermini class. It’s easy to see why Toyota has refreshed the car with this new facelifted version, then. Toyota has also updated the interior with some new materials, although the design is very similar to the previous car.  ',
                      '210 km/h',
                      '5',
                      '1.5 L-4',
                      '4.5',
                      1200,
                      8400,
                      33500,
                      '2017',
                      '110,000',
                      'Automatic',
                      'Petrol',
                      '1500',
                      'Red',
                      'assets/images/yellow.png',
                      'assets/images/black.png',
                      'assets/images/white.png',
                      -19.98511992632452,
                      57.61295977369659,
                      'assets/images/toyotayarisc1.png',
                      'assets/images/toyotayarisc2.png',
                      'assets/images/toyotayarisc3.png',
                      context),
                  _buildCard(
                      'assets/images/nissanlogo.png',
                      'Rogue 2015',
                      'Nissan',
                      'Les Barachois de Grand Gaube, Phase 2, Cashmir Rd, Grand Gaube',
                      'assets/images/nissanrogue.png',
                      'assets/images/nissanrogue1.png',
                      'assets/images/nissanrogue2.png',
                      'The attractive and stylish 2015 Nissan Rogue is a compact crossover that offers seating for five or even seven passengers. It has a lot to offer for families, but the compact-crossover market is full of excellent choices so it is becoming harder and harder for vehicles to stand out in the crowd.',
                      '190 km/h',
                      '5',
                      '1.5 V.C.T',
                      '4.7',
                      1300,
                      9100,
                      36400,
                      '2015',
                      '205,000 Km',
                      'Automatic',
                      'Petrol',
                      '1500',
                      'Grey',
                      'assets/images/green.png',
                      'assets/images/blue.png',
                      'assets/images/black.png',
                      -20.01514274971801,
                      57.67025226152074,
                      'assets/images/nissanroguec1.png',
                      'assets/images/nissanroguec2.png',
                      'assets/images/nissanroguec3.png',
                      context),
                  _buildCard(
                      'assets/images/v.png',
                      'Bora 2005',
                      'Volkswagen',
                      'Vivéa Business Park, Moka',
                      'assets/images/volkbora.png',
                      'assets/images/volkbora1.png',
                      'assets/images/volkbora2.png',
                      'The Yanks cannot get enough of the booted Bora, outselling the hatchback Golf three to one, yet over here the trickle of Boras leaving Volkswagen showrooms is engulfed by the tidal wave of Golf variants.Standard features on all trim levels include air conditioning, anti-lock brakes, power assisted steering, twin airbags plus front seat side airbags, electric windows and door mirrors and central locking.',
                      '210 km/h',
                      '5',
                      '2.0 L G',
                      '4.7',
                      1000,
                      6500,
                      29000,
                      '2005',
                      '150,000 Km',
                      'Manual',
                      'Petrol',
                      '1200',
                      'Grey',
                      'assets/images/red.png',
                      'assets/images/yellow.png',
                      'assets/images/black.png',
                      -20.223772539865486,
                      57.53129454672014,
                      'assets/images/volkborac1.png',
                      'assets/images/volkborac2.png',
                      'assets/images/volkborac3.png',
                      context),
                  _buildCard(
                      'assets/images/nissanlogo.png',
                      'NV200',
                      'Nissan',
                      'Le Cap Car Hire Ltd, Cap Malheureux',
                      'assets/images/nissannv200.png',
                      'assets/images/nissannv2001.png',
                      'assets/images/nissannv2002.png',
                      'The NV200 is a very slim, compact van that runs on relatively small wheels for maximum manoeuvrability around town. However, this does mean the ride is a bit bouncy on the open road, while the van isn’t really suited to long motorway journeys.',
                      '190 km/h',
                      '7',
                      '1.5 D.C.I',
                      '4.6',
                      1200,
                      8400,
                      33500,
                      '2016',
                      '72,000 Km',
                      'Automatic',
                      'Diesel',
                      '1500',
                      'Black',
                      'assets/images/red.png',
                      'assets/images/blue.png',
                      'assets/images/white.png',
                      -19.98517034011908,
                      57.61313143507031,
                      'assets/images/nissannv200c1.png',
                      'assets/images/nissannv200c2.png',
                      'assets/images/nissannv200c3.png',
                      context),
                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(
      String brand,
      String model,
      String name,
      String location,
      String imageUrl,
      String imageUrl1,
      String imageUrl2,
      String description,
      String speed,
      String seats,
      String engine,
      String stars,
      double price,
      double priceW,
      double priceM,
      String date,
      String mileage,
      String trans,
      String fuel,
      String cc,
      String color,
      String color1,
      String color2,
      String color3,
      double coord1,
      double coord2,
      String chooseC1,
      String chooseC2,
      String chooseC3,
      context) {
    return Padding(
        padding: EdgeInsets.only(top: 0.0, bottom: 10, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailScreen2(
                    name: name,
                    model: model,
                    brand: brand,
                    imageUrl: imageUrl,
                    imageUrl1: imageUrl1,
                    imageUrl2: imageUrl2,
                    description: description,
                    speed: speed,
                    seats: seats,
                    engine: engine,
                    price: price,
                    priceW: priceW,
                    priceM: priceM,
                    trans: trans,
                    fuel: fuel,
                    cc: cc,
                    color1: color1,
                    color2: color2,
                    color3: color3,
                    location: location,
                    date: date,
                    stars: stars,
                    coord1: coord1,
                    coord2: coord2,
                    cars: [],
                    color: color,
                    mileage: mileage,
                    chooseC1: chooseC1,
                    chooseC2: chooseC2,
                    chooseC3: chooseC3,
                  ),
                ),
              );
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(right: 13, bottom: 0, top: 10),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child: Text(
                                  'Seat: ' + seats,
                                  style: TextStyle(
                                      fontFamily: 'Barlow',
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .backgroundColor,
                                      letterSpacing: 2),
                                ),
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  date,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .backgroundColor,
                                      letterSpacing: 2),
                                ),
                              ]),
                        ],
                      )),
                  Hero(
                      tag: imageUrl,
                      child: Container(
                          height: 100.0,
                          width: 1600.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imageUrl),
                                  fit: BoxFit.contain)))),
                  SizedBox(height: 7.0),
                  /*Text(date,
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),*/
                  Text(
                    name,
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        letterSpacing: 1),
                  ),
                  Text(
                    model,
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'CC: ' + cc,
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    trans,
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        letterSpacing: 1),
                  ),
                ]))));
  }
}