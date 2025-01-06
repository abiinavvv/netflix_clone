import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloned_netflix/constant/apiKey.dart';
import 'package:cloned_netflix/model/movie_detail_model.dart';
import 'package:cloned_netflix/model/movie_model.dart';
import 'package:cloned_netflix/model/reels.dart';
import 'package:http/http.dart' as http;

class Api {
  static const trending = '${baseUrl}trending/movie/week$key';
  static const upcoming = '${baseUrl}movie/upcoming$key';
  static const nowPlaying = '${baseUrl}movie/now_playing$key';
  static const topRated = '${baseUrl}tv/top_rated$key';
  static const popular = '${baseUrl}tv/popular$key';

  static const reelFlix =
      'https://run.mocky.io/v3/a6676c23-b7bd-4c4a-8faa-27a0940f2d50';

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await http.get(Uri.parse(trending));

      // Handling various status codes
      switch (response.statusCode) {
        case 200: // Success
          final decodeData = json.decode(response.body)['results'] as List;
          log('Movies fetched successfully: $decodeData');
          return decodeData.map((movie) => Movie.fromJson(movie)).toList();

        case 400: // Bad Request
          log('Bad Request: ${response.body}');
          throw Exception('Bad request - Invalid request made to the server.');

        case 401: // Unauthorized
          log('Unauthorized: ${response.body}');
          throw Exception(
              'Unauthorized - Check your API key or authentication token.');

        case 403: // Forbidden
          log('Forbidden: ${response.body}');
          throw Exception(
              'Forbidden - You don’t have permission to access this resource.');

        case 404: // Not Found
          log('Not Found: ${response.body}');
          throw Exception('Not found - The requested resource does not exist.');

        case 500: // Internal Server Error
          log('Internal Server Error: ${response.body}');
          throw Exception('Internal server error - Try again later.');

        default: // Other unhandled status codes
          log('Unhandled status code: ${response.statusCode}');
          throw Exception(
              'Unexpected error occurred - Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Catching unexpected errors
      log('Error occurred: $error');
      throw Exception('Something went wrong: $error');
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

  Future<List<Reel>> getReels() async {
    final response = await http.get(Uri.parse(reelFlix));
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['reels'];
      return jsonData.map((data) => Reel.fromJson(data)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Resource not found (404). Check the URL.');
    } else {
      throw Exception(
          'Failed to fetch data. Status code: ${response.statusCode}');
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
      final decodeDate = MovieDetailModel.fromJson(jsonDecode(response.body));
      MovieDetailModel.fromJson(jsonDecode(response.body));
      log(decodeDate.toString());

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
