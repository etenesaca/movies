import 'package:flutter/material.dart';
import 'package:movies/src/providers/search_provider.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget txtField = TextField(
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
    print('Refrescando');
    Widget res = ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(movies[index]);
        });
    return res;
  }

  Widget _buildItem(Movie movie) {
    return ListTile(
      title: Text(
        movie.title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
