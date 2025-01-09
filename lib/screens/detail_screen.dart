import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> celebrity;

  const DetailScreen({super.key, required this.celebrity});

  String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  String formatCountryCode(String countryCode) {
    return countryCode.toUpperCase();
  }

  String formatList(List<dynamic>? list) {
    if (list == null || list.isEmpty) return 'Unknown';
    return list.map((item) => toTitleCase(item.toString())).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          toTitleCase(celebrity['name'] ?? 'Detail'),
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${toTitleCase(celebrity['name'] ?? 'Unknown')}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
                'Net Worth: \$${celebrity['net_worth']?.toString() ?? 'Unknown'}'),
            const SizedBox(height: 10),
            Text('Gender: ${toTitleCase(celebrity['gender'] ?? 'Unknown')}'),
            const SizedBox(height: 10),
            Text(
                'Nationality: ${formatCountryCode(celebrity['nationality'] ?? 'Unknown')}'),
            const SizedBox(height: 10),
            Text('Height: ${celebrity['height']?.toString() ?? 'Unknown'} m'),
            const SizedBox(height: 10),
            Text(
                'Birthday: ${toTitleCase(celebrity['birthday'] ?? 'Unknown')}'),
            const SizedBox(height: 10),
            Text(
                'Occupations: ${formatList(celebrity['occupation'] as List<dynamic>?)}'),
          ],
        ),
      ),
    );
  }
}
