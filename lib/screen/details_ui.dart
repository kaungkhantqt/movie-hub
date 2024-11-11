import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_hub/model/details.dart';
import 'package:movie_hub/screen/home.dart';
import 'package:movie_hub/service/api_service.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<Details> details;

  @override
  void initState() {
    super.initState();
    details = getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        centerTitle: true,
        title: const Text("Details"),
      ),
      body: FutureBuilder<Details>(
        future: details,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              "Error: ${snapshot.error}",
              style: const TextStyle(color: Colors.red),
            ));
          } else if (snapshot.hasData) {
            final detail = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                        "https://image.tmdb.org/t/p/original/${detail.posterPath}"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    detail.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "language: ${detail.originalLanguage.toUpperCase()}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "vote: ${detail.voteCount}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "release_date: ${DateFormat.yMMMd().format(detail.releaseDate)}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Watch Now"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Download Now"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Overview:",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      Text(
                        detail.overview,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey, fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No details available"));
          }
        },
      ),
    );
  }
}
