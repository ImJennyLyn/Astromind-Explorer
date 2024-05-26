import 'dart:async';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> with TickerProviderStateMixin {
  AudioPlayer audioPlayer = AudioPlayer();

  List<String> diceFaces = [
    'images/dice/dice1.png',
    'images/dice/dice2.png',
    'images/dice/dice3.png',
    'images/dice/dice4.png',
    'images/dice/dice5.png',
    'images/dice/dice6.png',
  ];

  late Timer _timer;
  int _animationSpeed = 200;
  int _rollDuration = 3;
  bool _isRolling = false;
  int _currentDiceIndex = 0;
  int _selectedDieIndex = 0;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _shakeAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _shakeController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _startShakeAnimation() {
    _shakeController.repeat(reverse: true);
  }

  void _stopShakeAnimation() {
    _shakeController.reset();
  }

  void rollDice() {
    setState(() {
      if (_isRolling) {
        return;
      }

      _isRolling = true;
      _animateRoll();
    });
  }

  void _animateRoll() {
    var random = Random();
    int rolls = 5;
    int currentRoll = 0;

    _timer = Timer.periodic(Duration(milliseconds: _animationSpeed), (timer) {
      setState(() {
        _currentDiceIndex = random.nextInt(diceFaces.length);
        currentRoll++;

        if (currentRoll >= rolls) {
          _timer.cancel();
          _isRolling = false;
          startTimer();
        }
      });
    });
  }

  void startTimer() {
    _timer = Timer(Duration(seconds: _rollDuration), () {
      print('Result: ${diceFaces[_currentDiceIndex]}');
      _timer.cancel();
      _stopShakeAnimation(); // Stop shaking animation
      checkResult();
    });

    _startShakeAnimation(); // Start shaking animation
  }

  void checkResult() {
    bool isWinning = _selectedDieIndex == _currentDiceIndex;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isWinning ? 'Congratulations!' : 'Better Luck Next Time'),
        content: Text(
          isWinning
              ? 'You won! The selected die matches the rolled die.'
              : 'You lost. The selected die does not match the rolled die.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );

    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/backgroundimage/Rolling.gif',
            ), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_shakeAnimation.value, 0.0),
                    child: Image.asset(
                      diceFaces[_currentDiceIndex],
                      width: 120,
                      height: 120,
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < diceFaces.length ~/ 2; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDieIndex = i;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          diceFaces[i],
                          width: 60,
                          height: 60,
                          color:
                              _selectedDieIndex == i ? Color(0x28d3adf0) : null,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = diceFaces.length ~/ 2; i < diceFaces.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDieIndex = i;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          diceFaces[i],
                          width: 60,
                          height: 60,
                          color:
                              _selectedDieIndex == i ? Color(0x43d3adf0) : null,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 150, // Adjust the width as needebd
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    rollDice();
                  },
                  child: Text(
                    'ROLL DICE',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff250a3d),
                      fontFamily: 'BlackHanSans',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    30), // Adjust the border radius as needed
                gradient: LinearGradient(
                  colors: [Color(0xffde3dfe), Color(0xfffe3da8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(
                        0x3cae2468), // Adjust the shadow color and opacity
                    spreadRadius: 2, // Adjust the spread radius
                    blurRadius: 5, // Adjust the blur radius
                    offset: Offset(0, 3), // Adjust the offset
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  audioPlayer.play(AssetSource(
                    'pop.mp3',
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameChoice()),
                  );
                },
                child: Icon(Icons.home, size: 40),
                backgroundColor: Colors.transparent,
                elevation: 0, // Remove the default elevation
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
                  audioPlayer.play(AssetSource(
                    'pop.mp3',
                  ));
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
                    'Welcome to the Dice Game!',
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
                    '1. Choose a Die: Tap on one of the dice images to select the die you want to play with.',
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
                    '2. Roll the Dice: Press the "Roll Dice" button to roll the selected die.',
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
                    '3. Check the Result: After the roll, see if your selected die matches the rolled die.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Add more tutorial steps as needed
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

void main() {
  runApp(MaterialApp(
    home: DiceGame(),
  ));
}
