import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_hub/model/popular.dart';
import 'package:movie_hub/screen/details_ui.dart';
import 'package:movie_hub/screen/home.dart';
import 'package:movie_hub/service/api_service.dart';

class PopularUi extends StatefulWidget {
  const PopularUi({super.key});

  @override
  State<PopularUi> createState() => _PopularUiState();
}

class _PopularUiState extends State<PopularUi> {
  ScrollController scrollController = ScrollController();
  late List<Result> movies = [];
  int page = 1;
  int totalPage = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPopularMovie();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getPopularMovie();
      }
    });
  }

  void getPopularMovie() async {
    if (isLoading) return;
    if (page == totalPage) return;
    setState(() {
      isLoading = true;
    });
    Popular popular = await getPopular(2);
    movies.addAll(popular.results);
    totalPage = popular.totalPages;
    page++;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        foregroundColor: textColor,
        backgroundColor: bgColor,
        centerTitle: true,
        title: const Text(
          "Popular",
        ),
      ),
      body: movies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: scrollController,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == movies.length - 1 && isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                        //color: Colors.white,
                        ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DetailsScreen(id: movies[index].id)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    height: 170,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original/${movies[index].posterPath}",
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  movies[index].title,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, 
                                  maxLines: 2,
                                ),
                                Text(
                                  "language: ${movies[index].originalLanguage.toUpperCase()}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "vote: ${movies[index].voteCount}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "release_date: ${DateFormat.yMMMd().format(movies[index].releaseDate)}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Watch Now"),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
