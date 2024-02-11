import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../models/sports_category.dart';

class CategoryDetails extends StatefulWidget {
  final SportsCategory sportsCategory;

  CategoryDetails({required this.sportsCategory});

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List<NewsItem> newsList = [];
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final String apiKey = '3646bcbb298542db98b297634666d561'; // Replace with your NEWS API key
    final String apiUrl = 'https://newsapi.org/v2/everything?q=${widget.sportsCategory.name.toLowerCase()}&apiKey=$apiKey';

    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];

        setState(() {
          newsList = articles.map<NewsItem>((article) => NewsItem.fromJson(article)).toList();
          isLoading = false; // Set loading to false after data is loaded
        });
      } else {
        // Handle errors
        print('Failed to load news: ${response.statusCode}');
        isLoading = false; // Set loading to false on error
      }
    } catch (e) {
      // Handle exceptions
      print('Error loading news: $e');
      isLoading = false; // Set loading to false on exception
    }
  }

  Future<void> _launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      print('Error launching URL: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sportsCategory.name),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _launchURL(newsList[index].url);
            },
            child: Card(
              elevation: 3,
              margin: EdgeInsets.all(8),
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                title: Text(newsList[index].title),
                subtitle: Text(newsList[index].description),
                leading: Image.network(
                  newsList[index].imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String description;
  final String imageUrl;
  final String url; // Add URL field

  NewsItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      url: json['url'] ?? '', // Get the news article URL
    );
  }
}
