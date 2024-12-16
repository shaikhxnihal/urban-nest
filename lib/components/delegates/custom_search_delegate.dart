import 'package:flutter/material.dart';

/// Custom SearchDelegate
class CustomSearchDelegate extends SearchDelegate<String> {
  // Sample search suggestions
  final List<String> searchItems = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Elderberry",
    "Fig",
    "Grape",
    "Mango",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Clear search query
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Back button
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show search results
    return Center(
      child: Text(
        'You searched for: $query',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Filter search suggestions based on query
    final suggestions = query.isEmpty
        ? searchItems
        : searchItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.search),
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}