import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/model/movie_details.dart';

import '../../../../core/string.dart';
import '../../../utils/star_calculator.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieDetails movieDetails;
  const MovieCardWidget({Key? key, required this.movieDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> stars = getStars(rating: movieDetails.rating, starSize: 12);
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.3,
            width: screenWidth * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: '$kThemoviedbBackgroundURL${movieDetails.imageUrl}',
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                //child: Image.network('$kThemoviedbBackgroundURL${movieDetails.imageUrl}'),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Color(0xFF1C1C1C),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 5,
                        blurRadius: 30,
                        offset: Offset(0, 3),
                      ),
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Wrap(
                              children: [
                                Text("${movieDetails.title} ",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white38
                                    )),
                                Text(
                                    (movieDetails.releaseDate == "")
                                        ? ""
                                        : "(${movieDetails.releaseDate})",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                        color: Colors.white38
                                    )),
                              ],
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 2),
                      if (stars.isNotEmpty) Row(children: stars),
                      const SizedBox(height: 2),
                      Text(
                        movieDetails.overview ?? '',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 9
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
