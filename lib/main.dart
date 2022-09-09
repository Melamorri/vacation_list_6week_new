import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/details': (context) => const DetailScreen(),
      },
    );
  }
}

class BaliPlace {
  final String ruName;
  final String baliName;
  String image;

  BaliPlace({
    required this.ruName,
    required this.baliName,
    required this.image,
  });
}

List<BaliPlace> placesList = [
  BaliPlace(
      ruName: "Индуистский храм Танах Лот",
      baliName: "Pura Tanah Lot",
      image:
          'https://i.pinimg.com/originals/ea/6f/59/ea6f590c70705c762f09c25f87ced2f9.jpg'),
  BaliPlace(
      ruName: "Убуд",
      baliName: "Ubud",
      image:
          'https://h8r3x6j3.rocketcdn.me/wp-content/uploads/2020/04/ubud-things-to-do-1-800x533.jpg'),
  BaliPlace(
      ruName: "Гунунг-Батур",
      baliName: "Gunung Batur",
      image:
          'https://i-bali.ru/media/k2/items/cache/867519228d1d5325856fc61d710ded0e_XL.jpg'),
];

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Достопримечательности Бали"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: placesList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Hero(
                            tag: placesList[index].ruName,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  NetworkImage(placesList[index].image),
                            ),
                          ),
                          title: Text(placesList[index].ruName),
                          subtitle: Text(placesList[index].baliName),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: BaliPlace(
                                ruName: placesList[index].ruName,
                                baliName: placesList[index].baliName,
                                image: placesList[index].image,
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context)?.settings.arguments as BaliPlace;
    return Scaffold(
      appBar: AppBar(
        title: Text(argument.ruName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Hero(
            tag: argument.ruName,
            child: Image(
              image: NetworkImage(argument.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              argument.baliName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
