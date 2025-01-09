import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _celebrities = [];
  bool _isLoading = false;
  String _error = '';
  bool _hasSearched = false;

  String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  Future<void> fetchCelebrities({String query = ''}) async {
    if (query.isEmpty) {
      setState(() {
        _celebrities = [];
        _hasSearched = false;
        _isLoading = false;
        _error = '';
      });
      return;
    }

    const url = 'https://api.api-ninjas.com/v1/celebrity';
    const apiKey = 'DpqKuYFZSNH7NTnXvtjJZA==c2br1QB1dsWCaYAV';

    try {
      final uri = Uri.parse('$url?name=$query');
      final response = await http.get(uri, headers: {
        'X-Api-Key': apiKey,
      });

      if (response.statusCode == 200) {
        setState(() {
          _celebrities = json.decode(response.body);
          _isLoading = false;
          _hasSearched = true;
        });
      } else {
        setState(() {
          _error = 'Failed to load data. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            Image.asset(
              'assets/images/Logo.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 10),
            const Text(
              'CELEBSCOPE',
              style: TextStyle(
                fontFamily: 'CooperHewitt',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  _isLoading = true;
                  _error = '';
                });
                fetchCelebrities(query: value);
              },
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ))
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : !_hasSearched
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Logo.png',
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Find your favorite celebrity by their name!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Start typing above to discover more.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _celebrities.length,
                      itemBuilder: (context, index) {
                        final celebrity = _celebrities[index];
                        return ListTile(
                          title:
                              Text(toTitleCase(celebrity['name'] ?? 'Unknown')),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(celebrity: celebrity),
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }
}
