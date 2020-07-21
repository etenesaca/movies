import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/providers/search_provider.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget txtField = TextField(
      autofocus: true,
      controller: context.watch<SearchMovieProvider>().txtSearchController,
      onChanged: (query) =>
          context.read<SearchMovieProvider>().onChangeText(query),
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Busca una pelicula...',
        hintStyle: TextStyle(color: Colors.white38),
        suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () =>
                context.read<SearchMovieProvider>().clearInputField()),
        prefixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {}),
        fillColor: Colors.white,
        focusColor: Colors.white,
      ),
    );

    Widget resList = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: txtField,
          decoration: BoxDecoration(color: Colors.white10),
        ),
        SizedBox(height: 8),
        Expanded(
            child: _buildResults(context.watch<SearchMovieProvider>().movies)),
        if (context.watch<SearchMovieProvider>().loading)
          Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
    return resList;
  }

  Widget _buildResults(List<Movie> movies) {
    Widget res = ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, movies[index]);
        });
    return res;
  }

  Widget _buildItem(BuildContext context, Movie movie) {
    String movieyear = '--';
    try {
      DateTime parsedDate = DateTime.parse(movie.releaseDate.toString());
      movieyear = parsedDate.year.toString();
    } catch (e) {}

    final titleStyle = TextStyle(
        color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13);
    final subtitleStyle = TextStyle(color: Colors.white60, fontSize: 11);
    final yearStyle = TextStyle(
        color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 11);

    final poster = (movie.posterPath == null)
        ? Extras().buildPlaceholderImg(double.infinity, 42, corners: 3)
        : Extras().buildPosterImg(
            movie.getPosterImgSmallUrl(), double.infinity, 42,
            corners: 3);

    return ListTile(
      title: Text(
        movie.title,
        style: titleStyle,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            movie.originalTitle,
            style: subtitleStyle,
          ),
          Text(
            movieyear,
            style: yearStyle,
          )
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Hero(tag: movie.idHero, child: poster),
      ),
      onTap: () {
        //close(context, null);
        Navigator.pushNamed(context, 'movie_detail',
            arguments: {'movie': movie});
      },
    );
  }
}
