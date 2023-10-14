import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({super.key, required this.specialty});
  late Specialty specialty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Search results for ${specialty.toString()}'),
      ),
      body: Center(
        child: Text('Search results for ${specialty.toString()}'),
      ),
    );
  }
}
