import 'package:flutter/material.dart';
import 'helpers/api_helpers.dart';
import 'models/post_model.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? bgImg;

  final TextEditingController searchController = TextEditingController();

  late Future<Weather?> getWeatherData;

  @override
  void initState() {
    super.initState();
    getWeatherData =
        WeatherAPIHelper.weatherAPIHelper.fetchWeatherData(city: 'surat');
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: getWeatherData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error:${snapshot.error}",
              ),
            );
          } else if (snapshot.hasData) {
            Weather? data = snapshot.data;

            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              controller: searchController,
                              decoration: const InputDecoration(
                                fillColor: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              String searchedCity = searchController.text;

                              setState(() {
                                getWeatherData = WeatherAPIHelper
                                    .weatherAPIHelper
                                    .fetchWeatherData(city: searchedCity);
                              });
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      searchController.text,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      ("${(data!.temp - 273.15).toInt()}"),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    //Spacer(),
                                    Text(
                                      (data.main),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 250,
                                width: 380,
                                child: (data.main == "Haze")
                                    ? const Image(
                                        image: AssetImage(
                                          "images gif/haze.gif",
                                        ),
                                      )
                                    : (data.main == "Mist")
                                        ? const Image(
                                            image: AssetImage(
                                              "images gif/Mist.gif",
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : (data.main == "Clouds")
                                            ? const Image(
                                                image: AssetImage(
                                                  "images gif/Clouds.gif",
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                            : const Image(
                                                image: AssetImage(
                                                  "images gif/clear.gif",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: h * 0.4,
                            width: w * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                            ),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Main:${data.main}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Desc:${data.description}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Humidity:${data.humidity}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Temp:${data.temp}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "wind Speed:${data.speed}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "country:${data.country}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      backgroundColor: Colors.white70,
    );
  }
}
