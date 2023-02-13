
class MovieDetails {
  late final int id;
  late final String title;
  String? releaseDate;
  //bool isFavorite;
  double? rating;

  String? overview;
  String? backgroundURL;
  String? imageUrl;

  MovieDetails({
    required this.id,
    required this.title,
    this.releaseDate,
    //this.isFavorite = false,
    this.rating,
    this.overview,
    this.backgroundURL,
    this.imageUrl
  });

  MovieDetails.fromMap(Map<String, dynamic> mapData){
    id = mapData['id'];
    title = mapData['title'];
    releaseDate = mapData['release_date'];
    rating = mapData['vote_average']  == null ? 0.0 : mapData['vote_average'].toDouble() ;
    overview = mapData['overview'];
    backgroundURL = mapData['backdrop_path'];
    imageUrl = mapData['poster_path'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'release_date' : releaseDate,
      'vote_average' : rating,
      'overview' : overview,
      'backdrop_path' : backgroundURL,
      'poster_path' : imageUrl
    };
  }
/*
  List<CustomMoviesButton> getGenresList(BuildContext context) {
    List<CustomMoviesButton> temp = [];
    genres.forEach((genre, genreId) {
      temp.add(
        CustomMoviesButton(
          onPressed: (() => navi.newScreen(
              newScreen: () => GenreWiseScreen(
                    genre: genre,
                    genreId: genreId,
                  ),
              context: context)),
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          color: kLightGrey,
          text: genre,
        ),
      );
    });
  
    return temp;
  }
*/
}
