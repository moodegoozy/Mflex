import 'package:flutter/material.dart';
import 'video_player_page.dart';

void main() => runApp(MFlixApp());

class MFlixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MFlix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.yellow,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.yellow),
        ),
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('MFlix',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'اسم المستخدم',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أدخل اسم المستخدم';
                    }
                    return null;
                  },
                  onSaved: (value) => username = value,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HomePage(username: username!)),
                      );
                    }
                  },
                  child: Text('تسجيل'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String username;
  final List<String> sampleMovies =
  List.generate(10, (index) => 'فيلم ${index + 1}');

  HomePage({required this.username});

  Widget buildSection(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow)),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sampleMovies.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VideoPlayerPage(
                          videoUrl:
                          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      sampleMovies[index],
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('مرحبًا $username', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildSection(context, 'الأفلام المميزة'),
          buildSection(context, 'أفلام الأكشن'),
          buildSection(context, 'الأكثر مشاهدة'),
        ],
      ),
    );
  }
}
