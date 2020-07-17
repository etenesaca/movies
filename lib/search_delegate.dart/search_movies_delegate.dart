import 'package:flutter/material.dart';
import 'package:movies/common/debouncer.dart';

class MovieSearch extends SearchDelegate {
  final debouncer = Debouncer();
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

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    debouncer.run(() {
      print('Buscando: $query');
    });
    return Container();
  }
}
