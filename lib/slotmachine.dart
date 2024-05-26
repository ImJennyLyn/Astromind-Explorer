// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class SlotMachine extends StatefulWidget {
  @override
  _SlotMachineState createState() => _SlotMachineState();
}

class _SlotMachineState extends State<SlotMachine> {
  AudioPlayer audioPlayer = AudioPlayer();

  List<String> symbols = [
    'images/slot/banana.png',
    'images/slot/bell.png',
    'images/slot/cherry.png',
    'images/slot/lemon.png',
    'images/slot/orange.png',
    'images/slot/plum.png',
  ];

  late Timer _timer;
  int _animationSpeed = 600; // Slower speed for animation (milliseconds)
// Spin time in seconds
  bool _isSpinning = false;
  int _currentSymbolIndex1 = 0;
  int _currentSymbolIndex2 = 1;
  int _currentSymbolIndex3 = 2;

  void spin() {
    setState(() {
      if (_isSpinning) {
        // Check if already spinning
        return;
      }

      _isSpinning = true;
      _animateSpin();
    });
  }

  void stopSpin() {
    setState(() {
      _timer.cancel();
      _isSpinning = false;
    });
  }

  void _animateSpin() {
    var random = Random();
    int spins = 5; // Number of spins before showing the final result
    int currentSpin = 0;

    _timer = Timer.periodic(Duration(milliseconds: _animationSpeed), (timer) {
      setState(() {
        _currentSymbolIndex1 = random.nextInt(symbols.length);
        _currentSymbolIndex2 = random.nextInt(symbols.length);
        _currentSymbolIndex3 = random.nextInt(symbols.length);

        currentSpin++;

        if (currentSpin >= spins) {
          _timer.cancel();
          _isSpinning = false;
          checkWinning(); // Check winning conditions after spinning
        }
      });
    });
  }

  void checkWinning() {
    if (symbols[_currentSymbolIndex1] == symbols[_currentSymbolIndex2] &&
        symbols[_currentSymbolIndex2] == symbols[_currentSymbolIndex3]) {
      // Jackpot! All three symbols match

      // Display a jackpot dialog
      _showResultDialog('Jackpot!', 'You won!');
    } else {
      // No match, inform the user
      _showResultDialog('No Win', 'Better luck next time!');
    }
  }

  void _showResultDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                stopSpin(); // Stop the spinning animation
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/backgroundimage/Slot.gif'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: null,
        extendBody: true,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 400),
                      Container(
                        width: 100,
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 167, 131, 3),
                            width: 4.0,
                          ),
                        ),
                        child: Image.asset(
                          symbols[_currentSymbolIndex1],
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 167, 131, 3),
                            width: 4.0,
                          ),
                        ),
                        child: Image.asset(
                          symbols[_currentSymbolIndex2],
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 167, 131, 3),
                            width: 4.0,
                          ),
                        ),
                        child: Image.asset(
                          symbols[_currentSymbolIndex3],
                          width: 100,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      spin();
                      audioPlayer.play(AssetSource('slot.mp3'));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                      minimumSize: Size(150, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Color.fromARGB(255, 209, 150, 0),
                    ),
                    child: Text(
                      'SPIN',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "WorkSans-SemiBold",
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffde3dfe),
                                    Color(0xfffe3da8)
                                  ],
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
                                    MaterialPageRoute(
                                        builder: (context) => GameChoice()),
                                  );
                                },
                                child: Icon(Icons.home, size: 40),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            ),
                          ),
                          SizedBox(width: 250),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffb014b5),
                                    Color(0xfffd1dc5)
                                  ],
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
                                  _showTutorialDialog(context);
                                },
                                child: Icon(Icons.help, size: 40),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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
                image: AssetImage('images/backgroundimage/dialog.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color.fromARGB(255, 147, 143, 147),
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
                    'Welcome to the Slot Machine!',
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
                    'How to Play?',
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
                    '1. Place Your Bet: Enter your desired bet amount using the provided input field or choose from preset options.!',
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
                    '2. Spin the Reels: Press the "SPIN" button to set the reels in motion and anticipate matching symbols for a win',
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
                    '3. If the symbols align, you win! enjoy the game!',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // ... (rest of the tutorial dialog content)
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 99, 19, 85),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
