import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart  ';
import 'package:meta/meta.dart';

import '../../data/model/movie_details.dart';
import '../../data/repository/movies_repository.dart';

part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeInitial());
  final MoviesRepository repository;
  static HomeCubit get(context) => BlocProvider.of(context);
  List<MovieDetails> moviesList = [];

  Future<void> getAllMovies() async{
    emit(MoviesLoaded());
    try{
      moviesList = await repository.getMovies();
      for(int i = 0;i< moviesList.length;i++){
        await repository.addMoviesToLocal(moviesList[i]);
      }
      print(moviesList.length);
      emit(MoviesSuccess());
    }catch(e){
      debugPrint(e.toString());
      emit(MoviesError(e.toString()));
    }
  }

  List<MovieDetails> moviesLocalList = [];

  Future<void> getAllMoviesLocal() async{
    emit(LocalMoviesLoaded());
    try{
      moviesLocalList = await repository.getMoviesFromLocal();
      if(moviesLocalList.isEmpty){
        await getAllMovies().then((value) async{
          moviesLocalList = await repository.getMoviesFromLocal();
        });
      }
      print('moviesLocalList ${moviesLocalList.length}');
      emit(LocalMoviesSuccess());
    }catch(e){
      debugPrint(e.toString());
      emit(LocalMoviesError(e.toString()));
    }
  }

  Future<void> refreshAllMoviesLocal() async{
    emit(RefreshMoviesLoaded());
    try{
      await repository.cleanMoviesLocalTable().then((value)async{
        await getAllMovies().then((value) async{
          moviesLocalList = await repository.getMoviesFromLocal();
        });
      });
      print('moviesLocalList ${moviesLocalList.length}');
      emit(RefreshMoviesSuccess());
    }catch(e){
      debugPrint(e.toString());
      emit(RefreshMoviesError(e.toString()));
    }
  }
}
