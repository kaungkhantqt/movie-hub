import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/model/playing_now.dart';
import 'package:movie_hub/model/popular.dart';
import 'package:movie_hub/model/top_rated.dart';
import 'package:movie_hub/model/upcoming.dart';
import 'package:movie_hub/screen/details_ui.dart';
import 'package:movie_hub/screen/popular_ui.dart';
import 'package:movie_hub/screen/top_rate_ui.dart';
import 'package:movie_hub/screen/upcoming_ui.dart';
import 'package:movie_hub/service/api_service.dart';
import 'package:movie_hub/widget/title_se.dart';

Color bgColor = const Color.fromARGB(205, 0, 11, 27);
Color textColor = const Color.fromARGB(226, 255, 255, 255);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<PlayingNow> playingNow;
  late Future<TopRate> topRate;
  late Future<Popular> popular;
  late Future<Upcoming> upcoming;

  @override
  void initState() {
    playingNow = getPlayingNow();
    topRate = getTopRate(1);
    popular = getPopular(1);
    upcoming = getUpcoming(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        title: const Text(
          "Movie Hub",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Oswald",
            letterSpacing: 2.0,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_3_outlined,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Playing Now",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontFamily: "Oswald",
                          letterSpacing: 1.10,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 1,
                      width: 105,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: playingNow,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.results.isNotEmpty) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data!.results.length,
                      itemBuilder: (context, index, playingNowIndex) {
                        final playNow = snapshot.data!.results[index];
                        String imageUrl =
                            "https://image.tmdb.org/t/p/original/${playNow.backdropPath}";
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DetailsScreen(id: playNow.id)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 1.4,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                },
              ),
              TitleSe(
                  title: "Top Rate",
                  width: 70,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const TopRateUi()));
                  }),
              FutureBuilder(
                future: topRate,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.results.isNotEmpty) {
                    return SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.results.length,
                        itemBuilder: (BuildContext context, int index) {
                          final topRate = snapshot.data!.results[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsScreen(id: topRate.id)));
                            },
                            child: Container(
                              height: 150,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/original/${topRate.posterPath}",
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                },
              ),
              TitleSe(
                  title: "Popular",
                  width: 60,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const PopularUi()));
                  }),
              FutureBuilder(
                future: popular,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.results.isNotEmpty) {
                    return SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.results.length,
                        itemBuilder: (BuildContext context, int index) {
                          final popular = snapshot.data!.results[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsScreen(id: popular.id)));
                            },
                            child: Container(
                              height: 150,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/original/${popular.posterPath}",
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                },
              ),
              TitleSe(
                  title: "Upcoming",
                  width: 60,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const UpcomingUi()));
                  }),
              FutureBuilder(
                future: upcoming,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.results.isNotEmpty) {
                    return SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.results.length,
                        itemBuilder: (BuildContext context, int index) {
                          final upcoming = snapshot.data!.results[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsScreen(id: upcoming.id)));
                            },
                            child: Container(
                              height: 150,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/original/${upcoming.posterPath}",
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            print(value);
          },
          currentIndex: 0,
          backgroundColor: Colors.black54,
          selectedItemColor: textColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Saved'),
            BottomNavigationBarItem(
                icon: Icon(Icons.download), label: 'Download'),
          ]),
    );
  }
}
