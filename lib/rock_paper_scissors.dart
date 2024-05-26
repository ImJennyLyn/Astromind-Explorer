import 'dart:math';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(RockPaperScissorsApp());
}

AudioPlayer audioPlayer = AudioPlayer();

class RockPaperScissorsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: null,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/backgroundimage/RPS.gif'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: RockPaperScissorsGame(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // Home Button
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
                      elevation: 0,
                    ),
                  ),
                  SizedBox(width: 80),
                  Container(
                    // Tutorial Button
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
                        _showTutorialDialog(context);
                      },
                      child: Icon(Icons.help, size: 40),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RockPaperScissorsLogic {
  final List<String> choices = ['Rock', 'Paper', 'Scissors'];
  String playerChoice = '';
  String computerChoice = '';
  String result = '';

  void playGame(String choice) {
    playerChoice = choice;
    computerChoice = choices[Random().nextInt(3)];
    result = calculateResult();
  }

  String calculateResult() {
    if (playerChoice == computerChoice) {
      return 'It\'s a draw!';
    } else if ((playerChoice == 'Rock' && computerChoice == 'Scissors') ||
        (playerChoice == 'Paper' && computerChoice == 'Rock') ||
        (playerChoice == 'Scissors' && computerChoice == 'Paper')) {
      return 'You win!';
    } else {
      return 'You lose!';
    }
  }
}

class RockPaperScissorsGame extends StatefulWidget {
  @override
  _RockPaperScissorsGameState createState() => _RockPaperScissorsGameState();
}

class _RockPaperScissorsGameState extends State<RockPaperScissorsGame> {
  final RockPaperScissorsLogic gameLogic = RockPaperScissorsLogic();

  String getImagePath(String choice) {
    switch (choice) {
      case 'Rock':
        return 'images/rock.png';
      case 'Paper':
        return 'images/paper.png';
      case 'Scissors':
        return 'images/scissors.png';
      default:
        return 'images/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(50), // Adjust the padding here for resizing
          decoration: BoxDecoration(
            color: Color.fromARGB(158, 40, 9, 72),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color.fromARGB(120, 255, 255, 255),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Choose your move:',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 233, 228, 238),
                  fontFamily: 'BlackHanSans',
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: gameLogic.choices
                    .map((choice) => ElevatedButton(
                          onPressed: () {
                            setState(() {
                              gameLogic.playGame(choice);
                            });
                          },
                          child: Image.asset(getImagePath(choice),
                              height: 60, width: 60),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Your choice: ${gameLogic.playerChoice}',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 214, 155, 240),
                fontFamily: 'BlackHanSans',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Computer\'s choice:',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 206, 165, 224),
                fontFamily: 'BlackHanSans',
              ),
            ),
            Image.asset(getImagePath(gameLogic.computerChoice),
                height: 100, width: 100),
          ],
        ),
        Text(
          'Result: ${gameLogic.result}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 244, 144, 130),
            fontFamily: 'WorkSans',
          ),
        ),
      ],
    );
  }
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
              color: Color.fromARGB(255, 112, 99, 126),
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
                  'Welcome to ROCK PAPER & SCISSOR!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '1. Choose Your Move: Select either Rock, Paper, or Scissors.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '2.See the Result: The computer will randomly choose its move, and the winner or a draw will be displayed.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '3. Enjoy the Game: Repeat and have fun playing Rock, Paper, Scissors!',
                  style: TextStyle(
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
              primary: Color.fromARGB(255, 54, 3, 93),
            ),
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
