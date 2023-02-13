import 'dart:convert';

import '../../core/string.dart';
import '../local_service/local_database_helper.dart';
import '../model/movie_details.dart';
import '../web_service/request_helper.dart';

class MoviesRepository{
  DBHelper helper = DBHelper();

  Future<List<MovieDetails>> getMovies() async{
    dynamic movies = await DioHelper.getData(endPoint: movieEndPoint);
    List<MovieDetails> moviesList = [];
    for (var i in movies['results']) {
      moviesList.add(MovieDetails.fromMap(i));
    }
    return moviesList;
  }

  Future<int> addMoviesToLocal(MovieDetails model) async{
    return await helper.insertToTable(table: localMoviesTable, row: model.toMap());
  }

  Future<List<MovieDetails>> getMoviesFromLocal() async{
    List<MovieDetails> moviesList = [];
    try{
      await helper.getFromTable(localMoviesTable).then((value) {
        for (var i in value) {
          moviesList.add(MovieDetails.fromMap(i));
        }
      });
    }catch(e){
      print(e);
    }
    return moviesList;
  }

  Future<void> cleanMoviesLocalTable()async {
    try{
      await helper.cleanLocalDatabase([localMoviesTable]);
    }catch(e){
      print(e);
    }
  }
}