import 'dart:async';
import 'package:flutter/material.dart';
import 'Menu.dart';
import 'MyTitle.dart';
import 'Grid.dart';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:audioplayers/audioplayers.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

AudioPlayer audioPlayer = AudioPlayer();

class _BoardState extends State<Board> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int move = 0;

  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

    // Replace 'background_image.jpg' with your actual image path
    final backgroundImage = Image.asset(
      'images/backgroundimage/Sliding.gif',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              backgroundImage,
              Column(
                children: <Widget>[
                  MyTitle(size),
                  SizedBox(height: 70),
                  Grid(numbers, size, clickGrid),
                  Menu(reset, move, secondsPassed, size),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                audioPlayer.play(AssetSource('pop.mp3'));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameChoice()),
                );
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffde3dfe),
                      Color(0xfffe3da8)
                    ], // Customize gradient colors
                  ),
                ),
                child: Icon(
                  Icons.home,
                  size: 40,
                ),
              ),
            ),
            SizedBox(width: 50),
            FloatingActionButton(
              onPressed: () {
                audioPlayer.play(AssetSource('pop.mp3'));
                _showTutorialDialog(context);
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffde3dfe),
                      Color(0xfffe3da8)
                    ], // Customize gradient colors
                  ),
                ),
                child: Icon(Icons.help, size: 40),
              ),
            ),
          ],
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
                image: AssetImage(
                    'images/backgroundimage/dialog.jpg'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color.fromARGB(255, 212, 193, 211),
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
                    'Welcome to Board Puzzle!',
                    style: TextStyle(
                      fontFamily: 'Salsa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Arrange the numbers in ascending order by sliding the empty space.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'How to Play:',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '1. Tap on a number next to the empty space to move it into the empty space.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '2. Continue moving numbers until they are in ascending order.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Good luck and enjoy!',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
                primary: Color.fromARGB(255, 116, 16, 138),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void clickGrid(index) {
    audioPlayer.play(AssetSource(
      'flipcard.mp3',
    ));
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You Win!!',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 220.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text(
                          'Close',
                          style: TextStyle(
                              color: Color.fromARGB(255, 166, 140, 201)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
