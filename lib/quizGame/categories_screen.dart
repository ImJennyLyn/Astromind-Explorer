import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'general_knowledge_screen.dart';
import 'science_screen.dart';
import 'math_screen.dart';
import 'history_screen.dart';
import 'technology_screen.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatelessWidget {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/backgroundimage/Q1.gif',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 100), // Add space above the category buttons
                buildCategoryButton(
                    context, 'General Knowledge', GeneralKnowledgeScreen()),
                buildCategoryButton(context, 'Science', ScienceScreen()),
                buildCategoryButton(context, 'Math', MathScreen()),
                buildCategoryButton(context, 'History', HistoryScreen()),
                buildCategoryButton(context, 'Technology', TechnologyScreen()),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Color(0xffde3dfe), Color(0xfffe3da8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3cae2468),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  audioPlayer.play(AssetSource('pop.mp3'));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameChoice()),
                  );
                },
                child: Icon(Icons.home, size: 40),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Color(0xffb014b5), Color(0xfffd1dc5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3cae2468),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  audioPlayer.play(AssetSource('pop.mp3'));
                  _showTutorialDialog(
                      context); // Call the function to show the tutorial dialog
                },
                child: Icon(Icons.help, size: 40),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(
      BuildContext context, String title, Widget screen) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: 70, // Set your desired height
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 172, 8, 177),
                  Color.fromARGB(255, 95, 4, 186),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xffffffff),
                    fontFamily:
                        'Poppins-Medium', // Replace with your desired font family
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showTutorialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backgroundimage/dialog.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color(0xffff8ffa),
                width: 5.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to the Quiz App Tutorial!',
                    style: TextStyle(
                      fontFamily: ' Salsa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '1. Choose a category from the main screen.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '2. Answer the questions to test your knowledge.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '3. Use the bottom bar to navigate home, get help, or control volume.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '4. Have fun and learn something new!',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffe215b9),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
