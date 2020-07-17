import 'package:flutter/material.dart';
import 'package:movies/common/debouncer.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

class MovieSearch extends SearchDelegate {
  final debouncer = Debouncer();
  final movieProvider = MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  _buildItem(BuildContext context, Movie movie) {
    String movieyear = '--';
    try {
      DateTime parsedDate = DateTime.parse(movie.releaseDate.toString());
      movieyear = parsedDate.year.toString();
    } catch (e) {}

    return ListTile(
      title: Text(movie.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(movie.originalTitle),
          Text(
            movieyear,
            style: TextStyle(
                color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
          )
        ],
      ),
      leading: Extras().buildPosterImg(
          movie.getPosterImgSmallUrl(), double.infinity, 42,
          corners: 3),
      onTap: () {
        close(context, null);
        Navigator.pushNamed(context, 'movie_detail',
            arguments: {'movie': movie, 'movieGenres': List<MovieGenre>()});
      },
    );
  }

  Widget callSearch() {
    if (query.isEmpty || query.trim().length < 3) {
      return Container();
    }
    return FutureBuilder(
        future: movieProvider.getMoviesByName(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;
            return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildItem(context, movies[index]);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return callSearch();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return callSearch();
  }
}
