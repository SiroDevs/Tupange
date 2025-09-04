import '../models/category.dart';
import '../models/game.dart';

abstract class RawData {
  static  String images = 'assets/images/';
  
  static List<Category> categories = [
    Category(id: 1, title: 'Planets',image: '${images}planets.jpg'),
    Category(id: 2, title: 'Countries',image: '${images}countries.jpg'),
    Category(id: 3, title: 'Animals',image: '${images}animals.jpg'),
  ];

  static List<Game> games = [
    Game(category: 1, title: 'Mercury',image: '${images}planets/planet1.png'),
    Game(category: 1, title: 'Venus',image: '${images}planets/planet2.png'),
    Game(category: 1, title: 'Earth',image: '${images}planets/planet3.png'),
    Game(category: 1, title: 'Mars',image: '${images}planets/planet4.png'),
    Game(category: 1, title: 'Jupiter',image: '${images}planets/planet5.png'),
    Game(category: 1, title: 'Saturn',image: '${images}planets/planet6.png'),
    Game(category: 1, title: 'Urenus',image: '${images}planets/planet7.png'),
    Game(category: 1, title: 'Neptune',image: '${images}planets/planet8.png'),
    Game(category: 1, title: 'Pluto',image: '${images}planets/planet9.png'),

    Game(category: 2, title: 'Algeria',image: '${images}countries/country1.jpg'),
    Game(category: 2, title: 'Botswana',image: '${images}countries/country2.jpg'),
    Game(category: 2, title: 'DR Congo',image: '${images}countries/country3.jpg'),
    Game(category: 2, title: 'Egypt',image: '${images}countries/country4.jpg'),
    Game(category: 2, title: 'Kenya',image: '${images}countries/country5.jpg'),
    Game(category: 2, title: 'Morocco',image: '${images}countries/country6.jpg'),
    Game(category: 2, title: 'Namibia',image: '${images}countries/country7.jpg'),
    Game(category: 2, title: 'Nigeria',image: '${images}countries/country8.jpg'),
    Game(category: 2, title: 'South Africa',image: '${images}countries/country9.jpg'),
    Game(category: 2, title: 'South Sudan',image: '${images}countries/country10.jpg'),
    Game(category: 2, title: 'Tanzania',image: '${images}countries/country11.jpg'),
    Game(category: 2, title: 'Tunisia',image: '${images}countries/country12.jpg'),
    Game(category: 2, title: 'Uganda',image: '${images}countries/country13.jpg'),

    Game(category: 3, title: 'Baboon',image: '${images}animals/animal1.jpg'),
    Game(category: 3, title: 'Buffalo',image: '${images}animals/animal2.jpg'),
    Game(category: 3, title: 'Elephant',image: '${images}animals/animal3.png'),
    Game(category: 3, title: 'Girrafe',image: '${images}animals/animal4.jpg'),
    Game(category: 3, title: 'Hippopotamus',image: '${images}animals/animal5.jpg'),
    Game(category: 3, title: 'Hyena',image: '${images}animals/animal6.jpg'),
    Game(category: 3, title: 'Leopard',image: '${images}animals/animal7.jpg'),
    Game(category: 3, title: 'Lion',image: '${images}animals/animal8.jpg'),
    Game(category: 3, title: 'Monkey',image: '${images}animals/animal9.jpg'),
    Game(category: 3, title: 'Rhino',image: '${images}animals/animal10.png'),
    Game(category: 3, title: 'Tortoise',image: '${images}animals/animal11.jpg'),
    Game(category: 3, title: 'Zebra',image: '${images}animals/animal12.jpg'),
  ];
}
