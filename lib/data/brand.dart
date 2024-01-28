import 'package:flutter/foundation.dart';

class Brand with ChangeNotifier {
  final String name;
  final String imageUrl;

  Brand({
    required this.name,
    required this.imageUrl,
  });
}

class Brands with ChangeNotifier {
  List<Brand> brands = [
    Brand(
      name: 'Toyota',
      imageUrl: 'assets/images/toyotalogo.png',
    ),
    Brand(
      name: 'Honda',
      imageUrl: 'assets/images/hondalogo.png',
    ),
    Brand(
      name: 'Nissan',
      imageUrl: 'assets/images/nissanlogo.png',
    ),
    Brand(
      name: 'Suzuki',
      imageUrl: 'assets/images/SUZUKILOGO.png',
    ),
    Brand(
      name: 'Mitsubishi',
      imageUrl: 'assets/images/mitsulogo.png',
    ),
    Brand(
      name: 'BMW',
      imageUrl: 'assets/images/bmwlogo.png',
    ),
    Brand(
      name: 'Mazda',
      imageUrl: 'assets/images/mazdalogo.png',
    ),
    Brand(
      name: 'Kia',
      imageUrl: 'assets/images/kialogo.png',
    ),
    Brand(
      name: 'Hyundai',
      imageUrl: 'assets/images/hyundailogo.png',
    ),
    Brand(
      name: 'Peugeot',
      imageUrl: 'assets/images/peugeotlogo.png',
    ),
    Brand(
      name: 'Mercedes',
      imageUrl: 'assets/images/mercedeslogo.png',
    ),
    Brand(
      name: 'Volkswagen',
      imageUrl: 'assets/images/v.png',
    ),
    Brand(
      name: 'Porsche',
      imageUrl: 'assets/images/porschelogo.png',
    ),
    Brand(
      name: 'Mini Cooper',
      imageUrl: 'assets/images/minologo.png',
    ),
    Brand(
      name: 'Audi',
      imageUrl: 'assets/images/audilogo.png',
    ),
  ];
}
