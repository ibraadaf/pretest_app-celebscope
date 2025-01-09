# Pretest App

A flutter project for pretest purposes

## CELEBSCOPE

A Data search application from famous celebrities using public API. Find your favorite celebrity by typing their name in the search bar and view their information by clicking on the list that appears.

## How to Use CELEBSCOPE App?

1. In VSCode, select the target device.
2. If you are using Android Emulator, start the emulator.
3. Execute flutter run in the terminal to run the app.

A splash screen will appear.

4. In the Login Screen, enter your email and password to log in. Remember that:
     - All fields must be filled in for successful login.
     - The email entered must be valid.
     - The password must be at least 8 characters.
   If login is successful, then you will be redirected to the home screen
5. On the home screen, you will not immediately see a list of celebrity names. To search for them, use the search bar above.
6. After that, you can click on one of the list of celebrity names that appears to see detailed information, including name, net worth, gender, nationality, occupation, height and birthday.

## Source Code

**pubspec.yaml:**

```ruby
name: pretest_app
description: "A new Flutter project."

publish_to: 'none' # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
  sdk: ^3.5.4

dependencies:
  flutter:
    sdk: flutter
  http: 1.2.2
  lottie: ^3.3.0
  animated_splash_screen:
  
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:

  uses-material-design: true

  assets:
    - assets/animations/
    - assets/fonts/
    - assets/images/Logo.png

  fonts:
    - family: CooperHewitt
      fonts:
        - asset: assets/fonts/CooperHewitt-Bold.otf
```

**main.dart:**

```ruby
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Celebscope',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
```

**splash_screen.dart:**

```ruby
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pretest_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadSplash();
  }

  Future<void> loadSplash() async {
    await Future.delayed(const Duration(seconds: 8));
    onDoneLoading();
  }

  void onDoneLoading() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          "assets/animations/splash_animation.json",
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
```

**login_screen.dart:**

```ruby
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.black,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Logo.png',
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'CELEBSCOPE',
                      style: TextStyle(
                        fontFamily: 'CooperHewitt',
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelStyle: const TextStyle(color: Colors.black),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email must be filled!';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelStyle: const TextStyle(color: Colors.black),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password must be filled!';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _login,
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

**home_screen.dart:**

```ruby
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
```

**detail_screen.dart:**

```ruby
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
```




