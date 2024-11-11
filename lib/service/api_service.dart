import 'package:http/http.dart' as http;
import 'package:movie_hub/model/details.dart';
import 'package:movie_hub/model/playing_now.dart';
import 'package:movie_hub/model/popular.dart';
import 'package:movie_hub/model/top_rated.dart';
import 'package:movie_hub/model/upcoming.dart';

String apiKey = '179bf293e96d67b570f7a85f6cc21eb8';

Future<PlayingNow> getPlayingNow() async {
  var url = Uri.https(
      'api.themoviedb.org', '3/movie/now_playing', {'api_key': apiKey});
  var response = await http.get(url);
  return playingNowFromJson(response.body);
}

Future<TopRate> getTopRate(int page) async {
  var url = Uri.https('api.themoviedb.org', '3/movie/top_rated',
      {'api_key': apiKey, 'page': '$page'});
  var response = await http.get(url);
  return topRateFromJson(response.body);
}

Future<Popular> getPopular(int page) async {
  var url = Uri.https('api.themoviedb.org', '3/movie/popular',
      {'api_key': apiKey, 'page': '$page'});
  var response = await http.get(url);
  return popularFromJson(response.body);
}

Future<Upcoming> getUpcoming(int page) async {
  var url = Uri.https('api.themoviedb.org', '3/movie/upcoming',
      {'api_key': apiKey, 'page': '$page'});
  var response = await http.get(url);
  return upcomingFromJson(response.body);
}

Future<Details> getDetails(int id) async {
  var url = Uri.https(
      'api.themoviedb.org', '3/movie/$id', {'api_key': apiKey});
  var response = await http.get(url);
  return detailsFromJson(response.body);
}
