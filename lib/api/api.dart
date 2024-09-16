import 'dart:convert';
import 'dart:developer';

import 'package:cloned_netflix/constant/apiKey.dart';
import 'package:cloned_netflix/model/movie_detail_model.dart';
import 'package:cloned_netflix/model/movie_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const trending = '${baseUrl}trending/movie/week$key';
  static const upcoming = '${baseUrl}movie/upcoming$key';
  static const nowPlaying = '${baseUrl}movie/now_playing$key';
  static const topRated = '${baseUrl}tv/top_rated$key';
  static const popular = '${baseUrl}tv/popular$key';

  static const fastLaugh =
      'http://run.mocky.io/v3/181f6fbf-c073-4245-9f04-5e0e7d15641f';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trending));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      print(decodeData);
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      print(response.statusCode);
      throw Exception();
    }
  }

  Future<List<Movie>> getUpcomingMovie() async {
    final response = await http.get(Uri.parse(upcoming));
    if (response.statusCode == 200) {
      final decodeDate = json.decode(response.body)['results'] as List;
      return decodeDate.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<Movie>> getNowPlaying() async {
    final response = await http.get(Uri.parse(nowPlaying));
    if (response.statusCode == 200) {
      final decodeDate = json.decode(response.body)['results'] as List;
      return decodeDate.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<Movie>> getTopRated() async {
    final response = await http.get(Uri.parse(nowPlaying));
    if (response.statusCode == 200) {
      final decodeDate = json.decode(response.body)['results'] as List;
      return decodeDate.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<Movie>> getPopular() async {
    final response = await http.get(Uri.parse(nowPlaying));
    if (response.statusCode == 200) {
      final decodeDate = json.decode(response.body)['results'] as List;
      return decodeDate.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<String>> getFastLaught() async {
    final response = await http.get(Uri.parse(fastLaugh));
    log(response.body);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['videos'] as List;
      return decodedData.map((video) => video as String).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<Movie>> getSearch(String searchText) async {
    final search = '${baseUrl}search/movie?query=$searchText';
    log(search);
    final response = await http.get(Uri.parse(search), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMDBmNDBjYTg4NTcxNWE0OTFkNTZjMjU0ZTEwZjg2YiIsIm5iZiI6MTcyNDM5MjIyNi41NDUzNTEsInN1YiI6IjY2YzRhM2NmNGRmMjk0NTZiYWQxMDQzOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.cs1qHT7HxFLPTgwuG0SGqRMEyjL8bh0fxdDzvvQGrOs'
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log(response.body);
      final decodeData = json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception();
    }
  }

  Future<MovieDetailModel> getDetails(int id) async {
    final details = '${baseUrl}movie/$id$key';
    
    final response = await http.get(Uri.parse(details));
    
    if (response.statusCode == 200) {
      final decodeDate =MovieDetailModel.fromJson(jsonDecode(response.body));MovieDetailModel.fromJson(jsonDecode(response.body));
      print(decodeDate.toString());

      return decodeDate;
          
    } else {
      throw Exception();
    }
  }

  Future<List<Movie>> getRecommendation(int id) async {
    final recommendation = '${baseUrl}movie/$id/recommendations$key';

    final response = await http.get(Uri.parse(recommendation));
    if (response.statusCode == 200) {
      final decodeDate = json.decode(response.body)['results'] as List;
      return decodeDate.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception();
    }
  }
}



// movie/$movieId

// movie/$movieId/recommendations